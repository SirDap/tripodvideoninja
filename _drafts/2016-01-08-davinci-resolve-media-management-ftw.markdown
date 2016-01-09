---
layout: post
title:  "The Quest for Media Management"
date:   2016-01-08 18:15:56 -0500
categories: organization footage fcp resolve
---

### The Dream

With over ten years of Indian classical music concert footage, i've always dreamt of tagging each by rāga, tāla, artist, audio/video quality, etc. and quickly pull up footage based on smart bins. Looking for rāga śivarañjanī? No problem. Dhrupad? Got that too. How about all files that need audio synced up? Coming right up.

Yup, the dream.


### Early Attempts

#### BulletProof

BulletProof was my first choice once upon a time. Their initial rollout of the app, which did not support linking media, prevented my initial efforts: terabytes of existing footage can't really be copied somewhere else. They eventually added linking, though, but then the application didn't support Sony XAVC-S, which i use heavily. As of 2015-06-08 (v 12.7.0 of the Shooter Suite) the application is retired, due to lack of public interest. https://www.redgiant.com/products/shooter-suite/downloads/ http://www.provideocoalition.com/fare-thee-well-red-giant-bulletproof

Cons:

* No drag and drop to add new files to the catalog. Won't even jump to that folder. (Designed more to offload from SD cards.)
* Markers can be added, but are all one color.
* Video playback buggy in _Review_ panel. For example in the following picture, after clicking marker to select in the right hand side to jump back to, the cursorhead remains the same and now will not play
* No smart bins. "Playlists" are all manual. 
* Metadata section is detailed, but vertical dropdown is a lot of scrolling ...
* No easy way to see recent catalogs. Have to open them manually.
* The real dealbreaker: no relinking of files in the catalog. Makes it difficult for mobile workflows.
* Export failed for 4K video (is it because it was expecting 1080p?)


#### FCP X

FCP X has never quite appealed to me for media management either—at least for my workflow. It's gone through iterations of growth since its original, 64-bit debut, and support for multiple libraries <as of version X> was the real game changer for organizing footage. Now we could finally create different libraries for different clients, store them wherever we need, etc.
	
The FCP X model seems to be "have all your media available at all times." All open Libraries reappear on launch, and since i tend to hop around these are from different clients, etc. i end up closing and reopening them. The Library model just seems too restrictive. 

Layout-wise too, FCP X does not seem set up for vast library organization. The clip viewer is rather small, and the clip selected does not show up in the timeline. Much of the screen is taken by the empty timeline! As soon as i change the clip width to something larger (to see and add markers, etc.) it becomes very difficult to see any other clips!

* Have to have one library open at all times.
* Projects are at the library level. So if i were to have different events for each concert all in the same project, then all the projects will be sitting together, making it difficult to focus on the one at hand. And because projects cannot be locked, there is greater chance i could modify a preciously finalized project.
* Pro: imports Finder keywords (which can be linked with OpenMeta keywords)
* Most robust relinking of files. If on the same drive and moved and renamed, symlink still works. If on a different drive, recursively checks folders for the same name. Can manually choose file if name has changed.
* Note: FCP X might be better for logging than Prelude. https://forums.creativecow.net/thread/335/70020#70020 `Prelude doesn't offer nearly this level of organization/logging. It's geared towards selects and a rough cut sequence.` 

### DaVinci Resolve 12: the New Kid On the Block

i'm really excited to try DaVinci Resolve 12 though! Resolve offers a dedicated _Media_ layout which seems exactly meant for this cataloging. Resolve requires the user setup system wide _Media Storage_ paths, kind of like FCP X Libraries, that apply to all projects ... Except here, new projects don't automatically import all the Smart Bins and clips you had open before.

In addition, Resolve's scene detection feature could be really handy for me to prep footage from live stream broadcasts. That way i'd have exactly which camera was cut where and sync them to the original masters by audio.

A big bonus is Resolve is both Mac and PC compatible, offering greater flexibility to pass along the catalog to others. 

* Relink media does not search recursively, nor does it allow files to be renamed. Since it only exports metadata during an actual timeline export, this means all the metadata is locked in and potentially can be lost.
* Drag into Media Bin now supported http://www.cineticstudios.com/blog/2015/7/resolve-12-beta-my-top-5-favorite-features.html

### Adobe Prelude

* Needs all files at loading, since cache needs to be created from reading each XMP inside the file. Scalability of large projects problematic possibly. https://forums.adobe.com/thread/1074392?start=0&tstart=0
* Exiftool can read XMP info!!!! Super cool
* Fatal flaw: since the file is changed, then relinking based on checksum will fail. Also requires entire file to be re-copied. Prelude offers no way of always writing a sidecar XMP file. https://forums.adobe.com/thread/1837913?start=0&tstart=0 Also note "Write XMP ID to Files On Import" option https://helpx.adobe.com/prelude/using/prelude-set-preferences.html Replace edit to the rescue: https://larryjordan.com/articles/fcpx-relinking/

### Silverstack

* Yay smart folders!

`The more effort you put into a MAM (media asset manager), the more value it has to your organization -- and the more dependent you become upon it. If you can't move your metadata freely in and out of a product, you are tying yourself to it. The more data you put in, the more expensive and painful it becomes to transition.

We're still in the early days of metadata for media, so I think these standards are only just beginning to emerge.

XMP is open and extensible, so it could a great solution to this problem.`
https://forums.creativecow.net/thread/335/26646


http://wolfcrow.com/blog/a-comparison-of-15-on-set-ingest-logging-dailies-grading-and-backup-software/