---
layout: post
title:  "The Quest for Media Management"
date:   2016-01-08 18:15:56 -0500
categories: organization metadata
---

### The Dream

With over ten years of Indian classical music concert footage, i've always dreamt of tagging each by rāga, tāla, artist, audio/video quality, etc. and quickly pull up footage based on smart bins. Looking for śivarañjanī? No problem. Dhrupad? Got that too. How about all files that need audio synced up? Coming right up.

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

BulletProof was my first attempt once upon a time. Their initial rollout of the app, which did not support linking media, prevented my initial efforts: terabytes of existing footage can't really be copied somewhere else. They eventually added linking, but then the application didn't support Sony XAVC-S, which i use heavily. As of June 8, 2015 (v12.7.0 of the Shooter Suite), the application is retired, [due to lack of public interest](https://www.redgiant.com/products/shooter-suite/downloads/ http://www.provideocoalition.com/fare-thee-well-red-giant-bulletproof). 

Even when it was officially supported, BulletProof left a large gap for media management:

* No drag and drop to add new files to the catalog. Won't even jump to that folder. (Designed more to offload from SD cards.)
* Markers can be added, but are all one color.
* Video playback buggy in _Review_ panel. For example in the following picture, after clicking a marker in the right hand side, the cursorhead remains the same instead of jumping to the location and then will not play!
* No smart bins. "Playlists" are all manual. 
* Metadata section is detailed, but vertical dropdown is a lot of scrolling ...
* No easy way to see recent catalogs. Have to open them manually.
* The real dealbreaker: no *relinking* of files in the catalog. Makes it difficult for mobile workflows.
* Export failed for 4K video (maybe because the program was expecting 1080p?)

#### FCP X

FCP X has gone through iterations of growth since its original, 64-bit debut, and support for multiple libraries in 10.1[^1] was the real game changer for organizing footage. Now we could finally create different libraries for different clients, store them wherever we need, etc.

Here's how it applied, at least to my workflow.

Cons
	
* The FCP X model seems to be "have all your media available at all times." All previously-open libraries reappear on launch, and since i tend to hop around different clients, closing and reopening them to keep content relevant is a little tedious. The library model just seems too restrictive.
* Layout-wise, FCP X does not seem set up for vast library organization. The clip viewer is rather small, and the selected clip does not show up in the large empty timeline below. As soon as the clip width is set to a smaller timescale (to see and add markers, etc.) it becomes very difficult to see any other clips!
* Libraries must have at least one "event" at all times.

Cons

* Projects are at the library level. So if i were to have different events for each concert all in the same project, then all the projects will be sitting together, making it difficult to focus on the one at hand. And because projects cannot be locked, there is greater chance i could modify a preciously finalized project.

Pros

* Imports Finder keywords (which can be linked with OpenMeta keywords)
* Most robust relinking of files. If on the same drive and moved and renamed, symlink still works. If on a different drive, recursively checks folders for the same name. Can manually choose file if name has changed.
* Note: FCP X might be better for logging than Prelude. https://forums.creativecow.net/thread/335/70020#70020 `Prelude doesn't offer nearly this level of organization/logging. It's geared towards selects and a rough cut sequence.` 

### DaVinci Resolve 12: the New Kid On the Block

Blackmagic has changed the game with the release of Resolve 12. A free, application for up to even 4K projects, DaVinci offers some of the old-school nitty gritty of FCP 7 with all the 64-bit goodness of FCP X.

Resolve even offers a dedicated _Media_ layout which seems exactly meant for cataloging. How does it fare?

Cons

* Resolve requires the user to set up system wide _Media Storage_ paths, kind of like FCP X Libraries, that apply to all projects ... Except here, new projects don't automatically import all the Smart Bins and clips you had open before.
* Relink media does not search recursively, nor does it allow files to be renamed.
* Metadata is only persisted outside of Resolve during an actual timeline export, meaning it is locked in Resolve until one starts editing.

Pros

* A big bonus is Resolve is both Mac and PC compatible, offering greater flexibility to pass along the catalog to others. 
* Note: drag into Media Bin [now supported](http://www.cineticstudios.com/blog/2015/7/resolve-12-beta-my-top-5-favorite-features.html)

### Adobe Prelude

* Needs all files at loading, since cache needs to be created from reading each XMP inside the file. Scalability of large projects problematic possibly. https://forums.adobe.com/thread/1074392?start=0&tstart=0
* Exiftool can read XMP info!!!! Super cool
* Fatal flaw: since the file is changed, then relinking based on checksum will fail. Also requires entire file to be re-copied. Prelude offers no way of always writing a sidecar XMP file. https://forums.adobe.com/thread/1837913?start=0&tstart=0 Also note "Write XMP ID to Files On Import" option https://helpx.adobe.com/prelude/using/prelude-set-preferences.html Replace edit to the rescue: https://larryjordan.com/articles/fcpx-relinking/

### Silverstack

[Silverstack](http://pomfort.com/silverstack/overview.html) *markets* itself as a robust media management application. i should be fair to say i haven't used the application, but from their website it seems to do much more. Some features like cloud sharing remind me  Kollaborate, and others like ProRes exporting remincse of EditReady. Their model is also a yearly subscription.

To be fair, i did not try the product myself, but from a first glance it seems to fall in

### Adobe Bridge

Adobe Bridge is basically a file explorer with XMP metadata capabilities. Initially 

http://wolfcrow.com/blog/a-comparison-of-15-on-set-ingest-logging-dailies-grading-and-backup-software/

[^1]: <http://www.izzyvideo.com/final-cut-pro-x-libraries/>