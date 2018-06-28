---
title: Livestreaming Lessons Re-Learned
date: 2018-06-28 16:22:00 Z
categories:
- livestream
layout: post
---

* TOC
{:toc}

### Always Record to an External Hard Drive

Apparently I forgot [my own advice]({% post_url 2016-01-24-live-streaming-lessons %}).

> Use fast external disks as the destination.

Even if recording to an uncompressed format like ProRes, always use a different drive than the OS' hard drive.

Even if it's an SSD.

### What Happened?

The result was particularly bad. Large dropped frames, audio/video sync issues, the works. And by works, I mean it's going to be a ton of work to cleanup too.

I didn't catch the error until after coming home, because all I was paying attention to was the CPU usage. Because I wasn't even streaming and merely using Wirecast as a multicam monitor, CPU usage was always around 30%, and so I thought, "Oh we're doing really good."

### Record to Disk Best Practices

Here are the recommendations from Craig over on a post[^1] at the Wirecast forums from Nov 2017:

> * Make sure you have the best possible throughput. Avoid using the system disk.
> * Separate internal SCSI drives are OK.
> * Avoid using USB2 drives.
> * If USB3 it should, ideally, be the only device on the bus. Even separate ports may be on the same bus. 
> * Best is to use SSD or RAID0 striped drives. 7200 RPM disks may be OK though.
> * Avoid spinning disks below 7200rpm
> * Keep CPU below 80% and below 70% is even better.
> * Make sure the drive never gets filled beyond 80% capacity. Especially for spinning disks, they can slow as they fill.
> * Make sure you're not confusing variable frame rate with dropped frames. Wirecast records a variable frame rate to avoid dropped frames and keep motion smooth.
> * If you're going to do post editing consider using MJPEG MOV instead of H.264.

Interestingly, another forum post[^2] suggests USB3 can be temperamental. One guy had dropped frames from a bad cable!

### Why it Worked Last Time

In my case, the internal Scratch disk was actually on the same physical SSD as the OS. It did have 500 GB free, but that was irrelevant.

Contrast this in May 2018 with the All-Night concert, where I was hooked up via Thunderbolt to a RAID 0 striped LaCie 4 TB drive and recording the livestream + HDV camera via Wirecast just fine.

### One Strike and You're Out... to Make it Better Next Time

Not recording to a dedicated, write disk is a fatal flaw. Let's put on that growth mindset, shall we?

### References
[^1]: Dropped Frames when recording to disc <https://telestreamforum.forumbee.com/r/m2knvp>
[^2]: ISO Dropping Frames <https://telestreamforum.forumbee.com/t/80tr9x/iso-dropping-frames>
