---
layout: post
title:  "HD Live Streaming Lessons"
date:   2016-01-02 08:42:56 -0500
categories: livestream hdv
---
## Draft

Last May, for Chhandayan's All-Night Concert 2015 in NYC, i tried using two cameras for the live stream for the first time. Little did i know, there was a lot to learn.

In hindsight there were a couple things i'd do differently next year:
* Save footage from Don't rely on Wirecast to save the HDV stream. Wirecast drops frames when CPU is taxed, and without timecode it's a super tedious to chop and fix. (Did i say the concert was all night?)
* Don't live stream from HDV over FireWire, especially when in conjunction with another (uncompressed) stream. This might have been part of our sync issues.
* Don't use Offload on the same laptop as Wirecast to dump SD cards from the 4K camera. About that. Probably caused some of the CPU spikes and dropped frames, because Offload checksums the files too.

Here is an example of the AV sync issue. The still center cam is HDV via FireWire and the panning closeup cam is uncompressed HDMI via a Blackmagic Mini Recorder. Audio is not switched and is constant from the closeup camera (pulled from the mixer). Note how the center cam's video is approximately 0.5 sec behind the audio, the time for the data to decompress!

<video width="100%" controls>
  <source src="{{ site.url }}/assets/videos/Live_Streaming_HDV_A_V_Sync_Issue_Example-SD.mp4" type="video/mp4">
Your browser does not support the video tag. Please use a browser that supports HTML5 to view the video.
</video>


References:
* A person who's also used the Mini Record and Intensity Shuttle USB on a MBP with success! http://stretchinternet.com/blog/2013/07/high-definition-three-camera-inputs-one-laptop-3500/
* Explains how it takes a few milliseconds longer to decode HDV video than the audio, hence the sync issue when using it as a live stream source http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=10289
* Confirms HDV buffering on output of ~ 1 sec https://obsproject.com/forum/threads/ability-to-synchronize-cameras.23166/