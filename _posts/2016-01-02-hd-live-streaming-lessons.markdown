---
layout: post
title:  "HD Live Streaming Lessons"
date:   2016-01-02 08:42:56 -0500
categories: livestream hdv
---
## Draft

Last May, for Chhandayan's All-Night Concert in NYC, i tried using two cameras for the live stream for the first time. Little did i know, there was a lot to learn.

In hindsight there were a couple things i'd do differently next year:
* Don't rely on Wirecast to save the HDV stream. Wirecast drops frames when CPU is taxed, and without timecode it's a super tedious to chop and fix. (Did i say the concert was all night?)
* Don't live stream from HDV over FireWire, especially when in conjunction with another (uncompressed) stream. This might have been part of our sync issues.
* Don't use Offload on the same laptop as Wirecast to dump SD cards from the 4K camera. About that. Probably caused some of the CPU spikes and dropped frames, because Offload checksums the files too.

Here is an example of the AV sync issue. The still center cam is HDV via FireWire and the panning closeup cam is uncompressed HDMI via a Blackmagic Mini Recorder. Audio is not switched and is constant from the closeup camera (pulled from the mixer). Note how the center cam's video is approximately 0.5 sec behind the audio, the time for the data to decompress!

<video width="420" height="236" controls>
  <source src="{{ sit.url }}/assets/videos/Chhandayan-ANC2015-Live-HDV_AV_Sync_Issue.mp4" type="video/mp4">
Your browser does not support the video tag. Please use one that supports HTML5 to display the content.
</video>
