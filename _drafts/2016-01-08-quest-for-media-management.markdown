---
layout: post
title:  "The Quest for Media Management"
date:   2016-01-08 18:15:56 -0500
categories: storage
---
* TOC
{:toc}

### The Dream

With over twenty years of Indian classical music concert footage, I've always dreamt of tagging each file by rāga, tāla, artist, audio/video quality, etc. and quickly pull up footage based on smart bins. Looking for Śivarañjanī? No problem. Dhrupad? Got that too. How about all files that need audio synced up? Coming right up.

Yup, the dream.

### Guiding Principle

Great words from a [2012 discussion about media managment on Creative Cow](https://forums.creativecow.net/thread/335/26646):

> The more effort you put into a MAM (media asset manager), the more value it has to your organization—and the more dependent you become upon it. If you can't move your metadata freely in and out of a product, you are tying yourself to it. The more data you put in, the more expensive and painful it becomes to transition.
> 
> We're still in the early days of metadata for media, so I think these standards are only just beginning to emerge.
>
> XMP is open and extensible, so it could a great solution to this problem.

Is there a solution worth investing in which still leaves one's workflow open and flexible?

### Early Attempts

#### BulletProof

BulletProof was my first attempt. The initial rollout of the app, which did not support media linking, prevented my efforts: terabytes of existing footage can't really be copied somewhere else.

The developers eventually added linking, but even then the application didn't support the Sony XAVC-S codec, which I use heavily. As of June 8, 2015 (v12.7.0 of the Shooter Suite), the application is retired, [due to lack of public interest](https://www.redgiant.com/products/shooter-suite/downloads/ http://www.provideocoalition.com/fare-thee-well-red-giant-bulletproof). 

Even when it was officially supported, BulletProof left a lot to be desired:

* Can't drag and drop files into the catalog. Designed to offload from SD cards only.
* Video playback buggy in _Review_ panel.
* No smart bins. All "Playlists" are all manual. 
* Metadata section is detailed, but the single vertical dropdown results in a lot of scrolling ...
* No easy way to display recent catalogs. Have to open them manually.
* The real dealbreaker: no *relinking* of files in the catalog. Makes it difficult to move media to different folders/drives.
* Export failed for 4K video

#### NLEs

**FCP X** has gone through many iterations since its original, 64-bit debut, and support for multiple libraries in 10.1[^1] was a real game changer for organizing footage. 

Here's why it didn't work, at least in my workflow.

* Layout-wise, FCP X does not seem set up for vast library organization. The clip viewer is rather small, and the large empty timeline below is wasted space. As soon as the clip width is increased (to see/add markers, etc.) it becomes very difficult to see any other clips!

* All previously-open libraries reappear on launch. I tend to hop around work for different clients, and closing and reopening them to keep content relevant is a little tedious. The library model just seems too restrictive.

* Potential to accidentally modify old projects. Projects cannot be locked.
* Importing FCP X keywords from Finder labels is awesome, but extended Finder attributes are tedious to persist with cloud storage without custom code.

**DaVinci Resolve** suffers from similar setbacks.

* Metadata is only persisted outside of Resolve during an actual timeline export, meaning it is locked in Resolve until one starts editing.
* Relinking media does not search recursively in folders, nor does it allow for files to be renamed.



In short, I find NLEs best for organizing metadata *while working on a specific project*, but not neccessarily for providing a picture of one's entire footage in general.



#### Adobe Prelude

Prelude places itself before the editing process and held a lot of promise. However

* Needs all files at loading, since cache needs to be created from reading each XMP inside/beside each file. Scalability of large projects problematic.
* Fatal flaw: since the file is changed, then relinking based on checksum will fail. Also requires entire file to be re-copied. Prelude offers no way of always writing a sidecar XMP file. https://forums.adobe.com/thread/1837913?start=0&tstart=0 Also note "Write XMP ID to Files On Import" option https://helpx.adobe.com/prelude/using/prelude-set-preferences.html Replace edit to the rescue: https://larryjordan.com/articles/fcpx-relinking/

### Silverstack

[Silverstack](http://pomfort.com/silverstack/overview.html) is actually a robust media management application.

Unlike Adobe Bridge, Silverstack provides comprehensive media management for editing workflows: checksum-based card offloading, ProRes transcoding, cloud storage for exports, multicam audio syncing, report genreation, and so on. It's like the combination of Adobe Bridge, EditReady, Kollaborate, and PluralEyes all put together.

It also 

Their model is also a yearly subscription.



To be fair, I did not try the product myself, but from a first glance it seems to fall in the category of applications that aren't m

### Adobe Bridge

Adobe Bridge is in essence a file browser with XMP metadata capabilities. 

http://wolfcrow.com/blog/a-comparison-of-15-on-set-ingest-logging-dailies-grading-and-backup-software/

[^1]: How to Use Libraries in Final Cut Pro X version 10.1 <http://www.izzyvideo.com/final-cut-pro-x-libraries/> 
[^2]: From the manual: "For some formats such as QuickTime (.mov) the XMP information is written into the media file. For formats that don't support writing to the media file, like MXF, the XMP is written into a sidecar file. The sidecar file is stored at the same location as the media file." <https://forums.adobe.com/thread/1074392?start=0&tstart=0>