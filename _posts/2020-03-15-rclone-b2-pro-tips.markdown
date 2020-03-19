---
layout: post
title: Rclone Video Archival Guide With Backblaze B2
subtitle: Double check your work
date:   2020-03-18 23:57:00 Z
categories: storage
---

* TOC
{:toc}

### Recap

The [previous post]({% post_url 2020-03-15-missing-checksums-with-synology-b2-cloud-sync %}) detailed how [Rclone](https://rclone.org) can reliably upload large files with their checksums to Backblaze unlike other programs. This post will outline the workflow and some gotchas to keep in mind when doing massive data loads over the internet.

With trial and error, I was able to archive 8 TB of footage from my Synology NAS to Backblaze B2 in about a month.

### To Keep in Mind

First, the overall workflow.

#### Remote to Remote is Possible

Keep in mind Rsync supports copying between two remotes directly. The computer running Rclone will stream data in RAM as it shuttles data between the two.

In fact that's what I mainly did: transferred assets from a personal B2 bucket to the organization's new B2 bucket. Pretty neat!

#### List Folders Syntax: `lsd`

After setting up your remote with `rclone config`, use the list directory command `lsd` to double check your source/target folders.

For example, if the B2 remote name is called `b2-remote1` then the command to list the root is:

```
rclone lsd b2-remote1:
```

Note the `:` at the end.

If a folder contains spaces, you use double quotes like this rather than backticks `\`.

```
rclone lsd b2-remote1:Videos/"Subfolder With Spaces/"
```

Also use trailing forward slashes `/` instead of asterisks `*` to indicate the files inside.

#### Consider `copy` instead of `sync`

From the docs[^2]:

> * `rclone copy` - Copy files from source to dest, skipping already copied.
> * `rclone sync` - Make source and dest identical, modifying destination only.

Depending on your intention, `copy` may be better.

#### Expect Errors and Verify

Although Rclone automatically retries upload errors (by default up to 10 times) there are few reasons why files never get uploaded. See the appendix for various scenarios.

Therfore, in a nutshell, always verify your transfer after ([see below](#the-check-command)).

#### Beware Quota Restrictions

Unexpected EOF (end of file) errors can occur when streaming from a remote because of Backblaze quota restrictions.

```
2018/08/09 16:53:44 DEBUG : CAM A/private/M4ROOT/CLIP/C0001.MP4: Cancelling large file upload due to error: unexpected EOF
2018/08/09 16:53:45 DEBUG : CAM A/private/M4ROOT/CLIP/C0001.MP4: Received error: unexpected EOF - low level retry 1/10
```

#### Double Check the Source Supports (and has) Checksums

Since Backblaze only supports SHA-1 checksums, the Rclone docs indicate the source must also support SHA-1 checksums.[^1]

> For a large file to be uploaded with an SHA1 checksum, the source needs to support SHA1 checksums. The local disk supports SHA1 checksums so large file transfers from local disk will have an SHA1. See [the overview](https://rclone.org/overview/#features) for exactly which remotes support SHA1.

So B2 to B2 syncs should always populate checksums, right? Wrong. It will only _if_ the source B2 bucket had checksums.

As detailed in the [previous post]({% post_url 2020-03-15-missing-checksums-with-synology-b2-cloud-sync %}), that means if the large files were copied with Rclone would they have checksums.

#### Rclone Browser is Great (but Deprecated) for Local <-> Remote

[Rclone Browser](https://github.com/mmozeiko/RcloneBrowser) is a wrapper that the same config as the CLI. Rclone Browser does not support direct remote to remote syncs, but it is good for normal use. Unfortunately the program deprecated in favor of the [WebGUI](https://rclone.org/gui/), but the latter doesn't let you yet upload things. 🤷🏾‍♂️

On Mac, Rclone Browser can be installed with Homebrew via `brew cask install rclone-browser`

#### ⬆︎ Reliability by ⬆︎ Chunk Size (using ⬆︎ RAM)

The default settings seem to be optimized for small files, like webpages.

* Single part upload cutoff of 200 MB
* Chunk size of 96 MB
* Four concurrent transfers

For whatever reason, the error rate with these defaults was higher than I expected ([see below](#performance-logs)).

Instead, I found better stability for large video files with:

* Cutoff of 1G
* 1G <= chunk size <=4G
* Two concurrent transfers

Note that all concurrent chunks are buffered into memory, so there is significantly more RAM usage with larger chunk sizes. Hence the downgrade to two transfers.

More specifics in the sync section [below](#the-sync-command).

#### Measure Twice, Cut Once: `dryrun`

Before discussing the `sync` command, it's imperative mention the `--dryrun` flag for the following reasons.

* Backblaze bills by usage/throughput
* B2 doesn't support renaming files after they are uploaded

Therefore, when running `rclone sync` always use the `--dryrun` option first.

### The `sync` command

My goto `sync` (or`copy`) command is:

`rclone sync <source> <dest> --exclude .DS_Store -vv --b2-upload-cutoff 1G --b2-chunk-size 1G --transfers 2`

#### Explanation of Flags

* `--exclude .DS_Store` to excluding Mac specific files
* `-vv` to enable DEBUG logging for visibility into chunk retries, etc.
* `--b2-upload-cutoff` files above this size will switch to a multipart chunked transfer
* `--b2-chunk-size` the size of the chunks, buffered in memory
* `--transfers` number of simulatenous transfers. `b2-chunk-size` x `transfers` must fit in RAM

#### Phased Approach with `--max-size`

Sometimes I found it helpful to transfer all files under a certain size limit first, say 1 GB, and then re-run the command for larger files.

To do so, add `--max-size 1G` to the `rclone sync` command.

### The `check` command

Always verify after a sync. Even if you think you don't need to. The command is straightforward:

`rclone check <source> <dest> --exclude .DS_Store`

If there are discrepancies the output will look like:

```
2018/09/05 07:45:04 ERROR : CAM 2/AVF_INFO/AVIN0001.BNP: File not in Local file system at /Volumes/Scratch/ToB2
2018/09/05 07:45:04 ERROR : CAM 2/AVF_INFO/AVIN0001.INP: File not in Local file system at /Volumes/Scratch/ToB2
2018/09/05 07:45:04 ERROR : CAM 2/AVF_INFO/AVIN0001.INT: File not in Local file system at /Volumes/Scratch/ToB2
2018/09/05 07:45:04 ERROR : CAM 2/AVF_INFO/PRV00001.BIN: File not in Local file system at /Volumes/Scratch/ToB2
```

#### Use error output to create diff file

By massaging the `rclone check` standard output into a new file with just the file names, it is possible to re-sync just these files. This saves us Backblaze read transactions on the files already copied.

Assuming a file `mydiff.txt`:

```
CAM 2/AVF_INFO/AVIN0001.BNP
CAM 2/AVF_INFO/AVIN0001.INP
CAM 2/AVF_INFO/AVIN0001.INT
CAM 2/AVF_INFO/PRV00001.BIN
```

the sync command is:

```
rclone sync <source> <dest> --files-from mydiff.txt <other flags>
```

Then, run `rclone check` again on all the files.

### The `cleanup` command

If your buckets are created with default settings, the file lifecyle is set to `Keep all versions`.

To purge deleted files, use a similar syntax to the `lsd` command.

```
rclone lsd b2-remote1:Videos/"Subfolder With Spaces/"
```

Also note that[^3]:

> Note that `cleanup` will remove partially uploaded files from the bucket if they are more than a day old.

### Appendix

#### Performance Logs

The exact command I used at first was

```
rclone sync b2-krish:Footage/"SD Card Archives/" b2-org:RawFiles/"Offloaded Video" -vv --exclude .DS_Store
```

and it completed, roughly 3 days later with a 5% error rate.

```
2018/08/12 19:46:55 INFO  : 
Transferred:   1.674 TBytes (6.491 MBytes/s)
Errors:                63
Checks:              2173
Transferred:         1123
Elapsed time:   75h6m1.4s
Transferring:
 *   CAM 1/PRIVATE/XDROOT/Clip/Clip0026.MXF: 99% /53.023G, 4.727M/s, 42s
...
2018/08/12 19:47:23 ERROR : Attempt 3/3 failed with 63 errors and: unexpected EOF
2018/08/12 19:47:23 Failed to sync: unexpected EOF
$
 ```

 Instead, by using a chunk size 1G and two max transfers (total 2G in RAM at a time) transfers were noticeably more stable.

 ```
 2018/09/01 22:40:13 INFO  : 
Transferred:   52.430 GBytes (5.752 MBytes/s)
Errors:                 0
Checks:               232
Transferred:          776
Elapsed time:  2h35m33.8s

2018/09/01 22:40:13 DEBUG : 14 go routines active
2018/09/01 22:40:13 DEBUG : rclone: Version "v1.42" finishing with parameters ["rclone" "copy" "b2-org:RawFiles/Offloaded Video/" "b2-org:RawFiles/SD Cards/" "--exclude" ".DS_Store" "-vv" "--transfers" "2" "--b2-chunk-size" "1G" "--b2-upload-cutoff" "1G" "--max-size" "1G"]
$
```

#### Upload cutoffs of "5G"

During my experiments, I once tried a 5G single-part cutoff: `--b2-chunk-size 2G --b2-upload-cutoff 5G --max-size 5G`. The docs state `This value should be set no larger than 4.657GiB (== 5GB)` however it threw this error.

```
2018/09/03 13:56:01 Failed to copy: File size too big: 5022908174 (400 bad_request)
```

So apparently `5G` is too high. `4G` worked fine though.

#### 500 Internal Server Error

 Something is wrong with Backblaze, usually a transient problem. Rclone will retry, by default up to 10 times with built-in rate limiting (pacer) as shown with the incident `a7691a3d7f71-e47fc872d7ba` below.

```
2018/08/09 16:53:12 DEBUG : CAM A/private/M4ROOT/CLIP/C0002.MP4: Error sending chunk 2 (retry=true): incident id a7691a3d7f71-e47fc872d7ba (500 internal_error): &api.Error{Status:500, Code:"internal_error", Message:"incident id a7691a3d7f71-e47fc872d7ba"}
2018/08/09 16:53:12 DEBUG : CAM A/private/M4ROOT/CLIP/C0002.MP4: Clearing part upload URL because of error: incident id a7691a3d7f71-e47fc872d7ba (500 internal_error)
2018/08/09 16:53:12 DEBUG : pacer: Rate limited, increasing sleep to 20ms
2018/08/09 16:53:12 DEBUG : pacer: low level retry 1/10 (error incident id a7691a3d7f71-e47fc872d7ba (500 internal_error))
2018/08/09 16:53:12 DEBUG : CAM A/private/M4ROOT/CLIP/C0002.MP4: Sending chunk 2 length 100663296
```

### References

[^1]: <https://rclone.org/b2/#sha1-checksums>
[^2]: <https://rclone.org/docs/#subcommands>
[^3]: <https://rclone.org/b2/#versions>
