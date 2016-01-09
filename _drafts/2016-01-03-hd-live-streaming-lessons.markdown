---
layout: post
title:  "HDV Live Streaming Lessons Learned"
date:   2016-01-03 15:25:56 -0500
categories: livestream hdv
---

Last May, for Chhandayan's All-Night Concert 2015 in NYC, i used two cameras in the live stream for the first time. Little did i know, there was a lot to learn.

In hindsight there were a couple things i'd do differently next year.

### Offload SD card footage to a separate laptop rather than using the streaming laptop
Red Giant's neat software [Offload](http://www.redgiant.com/products/offload/){:target="_blank"} made it really simple to transfer footage from the Sony 4K cam. Since it also compares checksums (of these giant video files), i suspect it caused some dropped frames—especially since Wirecast was also writing to the same disk!

Best to use another machine, like a MacBook Air to dump SD footage. Any machine with a fast, built-in SD card reader really. (Did that part correctly at least.)

### Use the HDMI output from the HDV camera when streaming with another camera/audio signal
If the streaming laptop had another Thunderbolt port, this would have been a no-brainer a long time ago: rock two [Blackmagic Mini Recorder](https://www.blackmagicdesign.com/products/ultrastudiothunderbolt/techspecs/W-DLUS-04){:target="_blank"}s via Thunderbolt. But it doesn't, and the Mini Recorder is an endpoint with no daisy chaining (why o why).

When the live stream source is HDV over FireWire, the camera actually compresses the video before it sends it over FireWire; DV video on the other hand, is a low enough bitrate to be uncompressed over FireWire. So compressed HDV has to be _decompressed_ by the receiving side, i.e. Wirecast, which takes a few milliseconds. This makes the HDV FireWire feed slightly behind
This might have been part of our sync issues.

Here is an example of the AV sync issue. The still center cam is HDV via FireWire and the panning closeup cam is uncompressed HDMI via a Blackmagic Mini Recorder. Audio is not switched and is constant from the closeup camera (pulled from the mixer). Note how the center cam's video is approximately 0.5 sec behind the audio, the time for the data to decompress!

<div class="videoWrapper">
<iframe src="https://player.vimeo.com/video/150565246?title=0&byline=0" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</div>

i originally thought, "Is it possible to delay the video of one source so that it's in sync with the other?" Although Wirecast allows for an audio delay offset on any source, there's no "source offset" option as [this Wirecast support thread explains](http://forum.telestream.net/forum/messageview.aspx?catid=44&threadid=10185){:target="_blank"}; one way might be to pipe the video through VLC to timeshift it with the play/pause button, but that's not precise enough here, for starters.


### Don't rely on Wirecast to save HDV footage 
Wirecast drops frames when CPU is taxed, and without timecode the saved stream is super tedious to chop and fix. (Did i mention already the concert was all-night?)

Furthermore, there's no straightforward way to save HDV footage *as* HDV footage in Wirecast. It'd have to be recompressed on the fly to some other format like either H.264 or ProRes, which causes more CPU cycles.

 Better would be to:

* Save to MiniDV tape and transfer afterwards. Gross, but works. Tapes are about $3 each on Amazon, but they create waste because they'll create dropouts if re-used too much. (Stay in school folks.)
* Use [ScopeBox](http://www.divergentmedia.com/scopebox) to save to disk via FireWire. Tried and tested approach for > 5 years, and preserves timecode. Maybe the streaming laptop could even handle it ... if we save to a separate disk. Saving an m2t stream doesn't take much CPU.

Note: recording to SSD via [Blackmagic HyperDeck Shuttle](https://www.blackmagicdesign.com/products/hyperdeckshuttle){:target="_blank"} is out, because we need the HDMI output for the live stream.

###References

* <http://stretchinternet.com/blog/2013/07/high-definition-three-camera-inputs-one-laptop-3500/>
	A person who's also used the Mini Record and Intensity Shuttle USB on a MBP with success! 
* <https://obsproject.com/forum/threads/ability-to-synchronize-cameras.23166/> 
	confirms HDV buffering on output of ~ 1 sec.
	<blockquote>
	Now I'm using also HDV cameras - Canon HX-A1 and Sony Z1. They are connected via firewire*, attached using Video source plugin (as it's m2ts (mpeg2) stream so can't be used directly at least in old OBS codebase). But this cameras has about 1 second of lag on firewire output, and that's how it works by design on most hdv cameras.
	</blockquote>
	
* <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=13312> suggests HDV video always lags uncompressed video/audio streams, and some users don't experience significant lag when using HDV as the only source (probably the case for me because of the MBP's specs).
	<blockquote>
	HDV decode would lag behind HDMI/SDI input decode.
	Additionally HDV video may decode ahead of HDV audio.
	As others have mentioned I would not mix the two if sync were critical.
	</blockquote>
	
* <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=10289> another thread on explaining HDV video lag
	<blockquote>
	HDV will lag because of the time it takes to decode the codec. Make sure your camera is in DV mode. 
	Audio will tend to be ahead of the video from HDV camera due to the aforementioned lag.
	</blockquote>
	
* <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=8362>
	<blockquote>
	HDV, because it's a GOP based codec, takes longer to decode than the audio, hence the sync delay.
	</blockquote>
