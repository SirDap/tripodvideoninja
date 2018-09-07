---
title: DRAFT Resizing Videos in After Effects
subtitle: Upconversion and RAM Struggles 
date: 2018-07-17 09:28:42 Z
categories:
- post
layout: post
---

* TOC
{:toc}
### Upconverting 480p Footage

This May, I tried something new and recorded an HD-source livestream to 480p ProRes 422 to help save on disk space/throughput.

All of the other raw, camera footage was in 1080p and I wondered if there was some way to "upconvert" the SD resolution footage. I especially needed to do so because some of the raw camera footage got corrupted, and the livestream was the way to salvage that angle.

### Instant 4K and After Effects

Despite the name, the Red Giant Instant 4K plugin is more like "Up to 4K." It's the latest version of their resizer plugin and is perfect for resizing to 1080p as well. From what I understand, the plugin uses some advanced interpolation algorithms to redraw each frame of the video as it expands it.

Instant 4K is part of Red Giant's Shooter Suite bundle and comes with plugins for Adobe Premiere and Adobe After Effects. I used After Effects CC 2018 plugin.

### A/B Video Comparison

Can anyone argue with "seeing is believing" regarding video?

Below are two uncompressed ProRes 422 snippets. Can you tell which one was resized and which was the original 480p version? Play them both at fullscreen to be fair.

<div class="videoWrapper">
<video controls width="640" height="360" preload="metadata" poster="{% asset deinterlace-clip2-orig-poster.png @path %}">
  <source src="{% b2 1080iHDVSavedAs720pH264Clip2-Up-to-4K-Better-Retiming.mov %}" type="video/mp4">
Your browser does not support the video tag.
</video>
</div>

<div class="videoWrapper">
<video controls width="640" height="360" preload="metadata" poster="{% asset deinterlace-clip2-orig-poster.png @path %}">
  <source src="{% b2 1080iHDVSavedAs720pH264Clip2-Up-to-4K-Better-Retiming.mov %}" type="video/mp4">
Your browser does not support the video tag.
</video>
</div>

### Plugin Workflow and Settings

1. Drag and drop the footage into After Effects
2. Right-click a video file and create a new composition from it
3. Adjust the composition settings to the destination resolution (e.g. HD 1080p). The source video should now be smaller than the canvas size.
4. Drag and drop the Instant 4K plugin onto the composition's viewer to apply. It should automatically resize to the canvas size!
5. Based on Red Giant's video guide, I configured the plugin to 6, 10, 3.
6. Send the composition to the Render Queue and export with Best Settings, ProRes 422.

### RAM Requirements

Resizing ProRes footage apparently can't be done on all machines. Here's why.

#### Are You Hongry for RAM?

Little did I know how incredibly RAM-intensive resizing footage is. This problem was particularly intensified by the sheer length of the video files: some of them were nearly 2 hours x 1 GB/min = 120 GB (classical music concert footage).

The 2011 MBP actually *ran out of RAM*. Like kaput. I tried a few things like increasing After Effect's memory allocation, etc. but it was all the essentially same. Anything larger than 30 minutes would crash. Queuing up multiple renders wouldn't work, because the program would need to be restarted before each one. The laptop was already maxxed out with 8 GB RAM.

This is when I remembered that nice desktop in the basement.

#### Return of the iMac

Unlike the MBP, the iMac has four RAM slots. Both machines had 8 GB total at the start, but the iMac impressively cranked out footage handsomely. It would seem that somehow this older iMac is just more stable, perhaps by virtue of it being a desktop.

Eventually the iMac also started freezing up for the larger files. However after upgrading the machine to 12 GB—two 2 GB chips and two 4 GB chips—it was invincible.

#### Observations on RAM Pressure

One thing I noticed was even after a render is complete, After Effects typically still holds onto the RAM. Some of it can be purged by manually by selecting **Edit > Purge > All Memory & Disk Cache...** but it's my observation that the RAM is only released completely after closing the program. Exiting the program usually takes a while too, sometimes of upwards of 2 minutes as it slowly siphons the RAM back.

On the iMac with 12 GB RAM however, I had no trouble queueing up multiple renders.

### References
[^1]: Dropped Frames when recording to disc <https://telestreamforum.forumbee.com/r/m2knvp>
[^2]: ISO Dropping Frames <https://telestreamforum.forumbee.com/t/80tr9x/iso-dropping-frames>
