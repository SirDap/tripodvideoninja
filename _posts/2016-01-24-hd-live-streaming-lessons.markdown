---
layout: post
title:  "HDV Livestreaming Lessons Learned"
date:   2016-01-24 14:34:38 -0500
categories: livestream hdv
---

Last May, for Chhandayan's All-Night Concert 2015 in NYC, i used two cameras in the livestream for the first time. Little did i know, there was a lot to learn.

In hindsight there were a couple things i'd do differently next year.

### Offload SD card footage to a separate laptop rather than using the streaming laptop
Red Giant's neat software [Offload](http://www.redgiant.com/products/offload/){:target="_blank"} made it really simple to transfer footage from the Sony 4K cam. Since it also compares checksums (of these giant video files), i suspect it caused some dropped frames—especially since Wirecast was also writing to the same disk!

Best to use another machine, like a MacBook Air to dump SD footage. Any machine with a fast, built-in SD card reader really. (Did that part correctly at least.)

### Stream Using HDMI Output from HDV (Especially When Streaming With Another Camera)
If the streaming laptop had another Thunderbolt port, this would have been a no-brainer a long time ago: rock two [Blackmagic Mini Recorder](https://www.blackmagicdesign.com/products/ultrastudiothunderbolt/techspecs/W-DLUS-04){:target="_blank"}s via Thunderbolt. But it doesn't, and the Mini Recorder is an endpoint with no daisy chaining (why o why).

When the livestream source is HDV over FireWire, the camera actually compresses the video before it sends it over FireWire[^2] [^4] [^5]; DV video on the other hand, is a low enough bitrate to be uncompressed over FireWire. So compressed HDV has to be _decompressed_ by the receiving side, i.e. Wirecast, which takes a few milliseconds. This makes the HDV FireWire feed slightly behind the HDMI feed and was precisely the trouble here.

Forums at Telestream also suggest HDV video always lags uncompressed video/audio streams, but some users don't experience significant lag when using HDV as the only source for both audio and video (probably the case for me because of the MBP's high specs)[^3].

Here is an example of the AV sync issue. The still center cam is HDV via FireWire and the panning closeup cam is uncompressed HDMI via a Blackmagic Mini Recorder. Audio is not switched and is constant from the closeup camera (pulled from the mixer). Note how the center cam's video is approximately 0.5 sec behind the audio—i.e. the time for the data to decompress!!

<div class="videoWrapper">
<iframe src="https://player.vimeo.com/video/150565246?title=0&byline=0" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</div>


"Is it possible to delay the video of one source so that it's in sync with the other?" Although Wirecast allows for an audio delay offset on any source, there's no "source offset" option. One way might be to pipe the video through VLC to timeshift it with the play/pause button[^6], but that's not precise enough here to say the least for starters.

The solution? Thankfully now[^8], unlike when it was first released in 2011[^7], the [Blackmagic Intensity Shuttle USB 3.0](){:target="_blank"} is compatible with Macs! Both are recognized with Wirecast which means one camera can use it via HDMI as a streaming input using Desktop Video 10.5.4 (released January 5, 2016). Better yet, it's the goto workflow at Harvard University Athletics: in fact, they use two Mini Recorder and one Intensity Shuttle USB on a MBP with success![^1]


### Don't rely on Wirecast to save HDV footage 
Wirecast drops frames when CPU is taxed and sometimes even adjusts the _frame rate_ on-the-go[^9]! With no timecode as well, the saved stream is super tedious to chop and fix. (Did i mention already the concert was all-night?)

Furthermore, there's no straightforward way to save HDV footage *as* HDV footage in Wirecast as far as i can tell. It's no [ScopeBox](http://www.divergentmedia.com/scopebox){:target="_blank"}. The incoming stream would have to be *recompressed* on the fly to some other format, like either H.264 or ProRes, which causes more CPU cycles.

Better would be to:

* Save to MiniDV tape and transfer afterwards. Gross, but works. Tapes are only about $3 each on Amazon, but they shouldn't be reused if dropouts are important, and even so can still have dropout problems. (Stay in school folks.)
* Use ScopeBox to save to disk via FireWire while using the HDMI for streaming. Tried and tested approach for > 5 years, and preserves timecode. Maybe the streaming laptop could even handle it ... if we save to a separate disk. Saving an m2t stream doesn't take much CPU.

Note: recording to SSD via [Blackmagic HyperDeck Shuttle](https://www.blackmagicdesign.com/products/hyperdeckshuttle){:target="_blank"} is out, because we need the uncompressed HDMI output for the livestream.

###References

[^1]: <http://stretchinternet.com/blog/2013/07/high-definition-three-camera-inputs-one-laptop-3500/>

[^2]: <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=8362>
	<blockquote>
	HDV, because it's a GOP based codec, takes longer to decode than the audio, hence the sync delay.
	</blockquote>

[^3]: <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=13312> 
	<blockquote>
	HDV decode would lag behind HDMI/SDI input decode.
	Additionally HDV video may decode ahead of HDV audio.
	As others have mentioned I would not mix the two if sync were critical.
	</blockquote>
	
[^4]: Confirms HDV buffering on output of ~ 1 sec. <https://obsproject.com/forum/threads/ability-to-synchronize-cameras.23166/>
	<blockquote>
	Now I'm using also HDV cameras - Canon HX-A1 and Sony Z1. They are connected via firewire*, attached using Video source plugin (as it's m2ts (mpeg2) stream so can't be used directly at least in old OBS codebase). But this cameras has about 1 second of lag on firewire output, and that's how it works by design on most hdv cameras.
	</blockquote>
	
[^5]: Another thread on explaining HDV video lag. <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=10289>
	<blockquote>
	HDV will lag because of the time it takes to decode the codec. Make sure your camera is in DV mode. 
	Audio will tend to be ahead of the video from HDV camera due to the aforementioned lag.
	</blockquote>
[^6]: <http://forum.telestream.net/forum/messageview.aspx?catid=44&threadid=10185>
[^7]: Intensity Shuttle USB 3.0 unsupported on Macs initially <http://forum.blackmagicdesign.com/viewtopic.php?f=3&t=3518>
[^8]: Looks like public beta for USB 3.0 support started with [Desktop Video 9.7.3 on June 16, 2013] (https://www.blackmagicdesign.com/support/readme/201836592e384a54a140e0bbfad03a63) but were [still in beta through May 28, 2014](http://forum.blackmagicdesign.com/viewtopic.php?f=11&t=22926) at least.
[^9]: Wirecast recommends always keeping the CPU under 80% <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=18511>