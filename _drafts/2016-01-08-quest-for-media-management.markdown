---
layout: post
title:  "The Quest for Media Management"
date:   2016-01-08 18:15:56 -0500
categories: storage
---
* TOC
{:toc}

### The Dream

With over twenty years of Indian classical music concert footage, I've always dreamt of tagging each file by rāga, tāla, artist, and audio quality to quickly pull up footage based on smart bins. Looking for Śivarañjanī? No problem. Dhrupad? Got that too. How about all files that need audio synced up? Coming right up.

Yup, the dream.

### Guiding Principle

Great words from a [2012 discussion about media managment on Creative Cow](https://forums.creativecow.net/thread/335/26646):

> The more effort you put into a MAM (media asset manager), the more value it has to your organization—and the more dependent you become upon it. If you can't move your metadata freely in and out of a product, you are tying yourself to it. The more data you put in, the more expensive and painful it becomes to transition.
> 
> We're still in the early days of metadata for media, so I think these standards are only just beginning to emerge.
>
> XMP is open and extensible, so it could a great solution to this problem.

Is there a solution worth investing in which still leaves one's workflow open and flexible?

### NLEs?

**FCP X** has gone through many iterations since its original, 64-bit debut, and support for multiple libraries in 10.1[^1] was a real game changer for organizing footage. 

Here's why FCP X isn't ideal.

- The layout of FCP X is not set up for vast library organization. The clip viewer is rather small, and the large empty timeline below is wasted space. As soon as the clip width is increased (to see/add markers, etc.) it becomes very difficult to see any other clips!
- All previously-open libraries reappear on launch. I tend to hop around work for different clients, and closing and reopening them to keep content relevant is a little tedious. The library model just seems too restrictive.
- Potential to accidentally modify old projects. Projects cannot be locked.



**DaVinci Resolve** suffers from similar setbacks.

- Metadata is only persisted outside of Resolve during the final timeline export, which means tags are locked in Resolve until one starts editing.
- Relinking media does not search recursively in folders for matches. Resolve also does not allow for manual relinking to renamed files.



In short, I find NLEs best for organizing metadata *when working on a specific project*, but not neccessarily for providing a picture of one's entire footage in general.

### Early Attempts

#### BulletProof

BulletProof was my first attempt at media management. The shiny new app however was only designed for offloading footage from cards, and did not support linking to reference media. Terabytes of existing footage on a network drive can't really be copied somewhere else.

As of June 8, 2015 (v12.7.0 of the Shooter Suite), the application is retired, [due to lack of public interest](https://www.redgiant.com/products/shooter-suite/downloads/ http://www.provideocoalition.com/fare-thee-well-red-giant-bulletproof). RIP.

#### Adobe Bridge

Adobe Bridge is a file browser with XMP metadata tagging capabilities. Bridge is a really attractive financially, since it is completely free for life[^3].

Bridge fails for making destructive edits to MOV files, just like Prelude. See it for yourself.

![]({% asset metadata-adobe-bridge.gif @path %}) 

As a browser, the program also requires all footage to be online, which isn't always ideal. XMP sidecars are also difficult to import into FCP X, and Bridge stays within the Adobe ecosystem.

http://wolfcrow.com/blog/a-comparison-of-15-on-set-ingest-logging-dailies-grading-and-backup-software/

#### Adobe Prelude

Prelude places itself before the editing process and held a lot of promise. However its fatal flaw is that it writes XMP metadata *inside* MOV containers, and this cannot be changed.[^5][^4][^2]

Prelude also does not integrate well with programs outside of Premiere.

* Needs all files at loading, since cache needs to be created from reading each XMP inside/beside each file. Scalability of large projects problematic.
* Fatal flaw: since the file is changed, then relinking based on checksum will fail. Also requires entire file to be re-copied. Prelude offers no way of always writing a sidecar XMP file. https://forums.adobe.com/thread/1837913?start=0&tstart=0 Also note "Write XMP ID to Files On Import" option https://helpx.adobe.com/prelude/using/prelude-set-preferences.html Replace edit to the rescue: https://larryjordan.com/articles/fcpx-relinking/



### Silverstack

[Silverstack](http://pomfort.com/silverstack/overview.html) is a comprehensive media management application.

It's similar in some ways to BulletProof: checksum-based card offloading, ProRes transcoding, and features some other features like cloud storage, audio syncing, report genreation, and so on. It's like the combination of Adobe Bridge, EditReady, Kollaborate, and PluralEyes all put together.

Silverstack dropped the ball when it did not export its tags as FCP X keywords. It exports things like camera and labels to FCP X, but not tags.

![]({% asset metadata-silverstack-export.gif @path %}) 

That's alright for me, since their yearly subscription starts at $399. 🤤



### Appendix: Early Attempts

#### Bullet Proof

Even when it was officially supported, BulletProof left a lot to be desired.

- Can't drag and drop files into the catalog. Designed to offload from SD cards only.
- Video playback was buggy.
- No smart bins. All "Playlists" are all manual. 
- No quick way to enter metadata. Have to scroll lots...
- No easy way to display recent catalogs. Have to open them manually.
- The real dealbreaker: no *relinking* of files in the catalog. Makes it difficult to move media to different folders/drives.
- Export failed for 4K video



[^1]: How to Use Libraries in Final Cut Pro X version 10.1 <http://www.izzyvideo.com/final-cut-pro-x-libraries/> 
[^2]: "For some formats such as QuickTime (.mov) the XMP information is written into the media file. For formats that don't support writing to the media file, like MXF, the XMP is written into a sidecar file. The sidecar file is stored at the same location as the media file." <https://forums.adobe.com/thread/1074392?start=0&tstart=0>
[^3]: It’s True: Adobe Bridge CC Is 100% Free for You to Download & Use <https://prodesigntools.com/free-adobe-bridge-cc.html>
[^4]: Official XMP Specification Whitepaper from Adobe, lists each format and whether or not the codec writes to sidecar XMP files <https://wwwimages2.adobe.com/content/dam/acom/en/devnet/xmp/pdfs/XMP%20SDK%20Release%20cc-2016-08/XMPSpecificationPart3.pdf>
[^5]: Helpful summary of which containers support embedded XMP metadata <https://forums.adobe.com/message/7518406>

<https://blog.frame.io/2018/01/31/fcpx-metadata/>