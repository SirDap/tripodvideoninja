---
layout: post
title:  "Livestreaming Lessons Learned"
date:   2016-01-24 14:34:38 -0500
categories: livestream
---

*[Updated Feb. 4, 2017 with additional Wirecast Record to Disk information.]*

*[Updated May 14, 2018 with renamed titles, edits, and updated Wirecast best practices.]*

* TOC
{:toc}

### Introduction

Last May, for Chhandayan's All-Night Concert 2015 in NYC, I cut between two cameras in the livestream for the first time. Little did I know, there was a lot to learn.

Here's what I'd do differently next time.

### Transfer SD Card Footage with a Separate Laptop
Red Giant's neat software [Offload](http://www.redgiant.com/products/offload/){:target="_blank"} made it really simple to transfer footage from the Sony AX100 cam. Since it also compares checksums of these giant video files, I suspect it spiked the CPU and caused some dropped frames—especially since Wirecast was writing to the same disk!

Best to use another machine like a MacBook Air to dump SD footage. Any machine with a fast, built-in or USB 3.0 SD card reader really.

### Always Ingest HDV Cams as Uncompressed HDMI Outputs

If the streaming laptop had another Thunderbolt port, this would have been a no-brainer a long time ago: rock two [Blackmagic Mini Recorder](https://www.blackmagicdesign.com/products/ultrastudiothunderbolt/techspecs/W-DLUS-04){:target="_blank"}s via Thunderbolt and call it a day. However my [2012 MacBook Pro 9,1](http://www.everymac.com/systems/apple/macbook_pro/specs/macbook-pro-core-i7-2.6-15-mid-2012-unibody-usb3-specs.html){:target="_blank"} has only one port, and the Mini Recorder is an endpoint with no daisy chaining (why o why).

When the livestream source is HDV over FireWire, the camera actually compresses the video before it sends it over [^2] [^4] [^5]; DV video on the other hand, is at a low enough bitrate to be uncompressed. So compressed HDV has to be _decompressed_ by the receiving side, i.e. Wirecast, which takes a few milliseconds. This makes the HDV FireWire feed lag slightly behind the other HDMI camera and creates an audio-video sync problem—especially when cutting/mixing with another camera live.

Forums at Telestream suggest HDV video always lags uncompressed video/audio streams, but some users don't experience significant lag when using HDV as the only source for both audio and video (probably the case for me because of the MBP's high specs)[^3].

Here is an example of the AV sync issue. The stationary center cam is HDV via FireWire and the panning closeup cam is uncompressed HDMI via a Blackmagic Mini Recorder. Audio is not switched and is always taken from the closeup camera (fed from the mixer). Note how the center cam's video is approximately 0.5 sec behind the audio—i.e. the time for the data to decompress!!

{% vimeo 150565246 %}

"Is it possible to delay the video of one source so that it's in sync with the other?" ~~Although Wirecast allows for an audio delay offset, there's no "source offset" option. One way might be to pipe the video through VLC to timeshift it with the play/pause button[^6], but that's not precise enough here to say the least for starters.~~ [Update] As of [Wirecast 7.0](https://telestreamforum.forumbee.com/t/h48sty/wirecast-7-0-released-june-29-2016){:target="_blank"}, sources now have a separate video delay feature. It would probably take some tuning though to get it right, and still might not be worth it since the decompression would still result in higher CPU usage.

The solution? Thankfully now[^8], unlike when it was first released in 2011[^7], the [Blackmagic Intensity Shuttle USB 3.0](https://www.blackmagicdesign.com/products/intensity){:target="_blank"} is compatible with Macs! Both are recognized by Wirecast which means one camera can use it via HDMI as a streaming input using Desktop Video 10.5.4 (released January 5, 2016). It's also the goto workflow at Harvard University Athletics (in fact, they use two Mini Recorders and one Intensity Shuttle USB on a MBP with success)![^1]


### Wirecast's *Record To Disk* ≠ Edit Grade Footage

1. **Wirecast drops frames and even adjusts the _frame rate_ on the fly[^9] to serve live content.** In live video, performance takes priority over data integrity. Dropping a few frames here or there won't make a visible difference to the end user. Wirecast does exactly this, typically around 80% CPU usage[^10] [^11]. However for frame-precise editing and multitrack syncing of any kind, every frame is vital. So using *Record to Disk* is not the right tool for raw footage at all.
2. **Wirecast won't save timecode.** Kinda makes sense, given the dropped frames. This makes it impossible to detect drops via any kind of timecode-break detection program. Thus the saved stream is super tedious to chop and fix if it is to be synced with another track.
3. **There's no way to save HDV footage *as* HDV footage in Wirecast.** It's no [ScopeBox](http://www.divergentmedia.com/scopebox){:target="_blank"}. As far as I can tell, the incoming stream would have to be *recompressed* on the fly to some other format like H.264, which causes more CPU cycles.

Better would be to either:

* **Save to MiniDV tape and transfer afterwards.** Cumbersome, but it technically works. Tapes are about $3 each on Amazon and transferring after takes time, but the main setback is sporadic dropouts during captures when every moment counts. (Stay in school folks.)
* **Save to disk via FireWire and leave the HDMI for streaming.** ScopeBox has been my tried and tested approach for > 5 years, and it preserves timecode. (*Maybe* the streaming laptop could even handle it if it saved to a separate disk...saving an m2t stream doesn't take much CPU.)
* **Save to disk via Wirecast using uncompressed formats like ProRes.** The way this works is by opening a separate, simultaneous project that only has the input from the HDV camera's HDMI output. The file size is kind of overkill, but this approach could definitely work if another laptop is not available. However the inherent risk of dropped frames is still lingering, and timecode is is still not saved.

Note: recording to SSD via [Blackmagic HyperDeck Shuttle](https://www.blackmagicdesign.com/products/hyperdeckshuttle){:target="_blank"} won't work, because we need the uncompressed HDMI output for the livestream and the camera has only 1 HDMI output.

### Best Practices for *Record To Disk*

Saving the livestream feed to disk is still helpful. Such footage is *not* a substitute for actual footage from the camera but can be used for quick YouTube posts or as a rough outline for post-production work. (For example, cuts can be detected automatically using programs like [Edit Detector](https://www.digitalrebellion.com/promedia/){:target="_blank"} and applied to post-production timelines, saving hours of multicam editing work.)

When doing so the following tricks minimize dropped frames:

1. **Either save in ProRes or in the same format as the livestream.** As this Wirecast forum post[^12] explains, each output format results in an additional real time encoder thus more CPU usage. H.264 can be particularly CPU intensive, especially when the settings specified cannot take advantage of hardware codecs. ProRes however is extremely light on the CPU, since it's uncompressed.
2. **Use fast external disks as the destination.** As the same post[^12] explains, writing to disk on slow external drives can also result in dropped frames. I find writing to the same internal disk can also cause performance degredation, interfering with the livestream. However USB 3 and Lightning drives have more than enough bandwidth and don't spike CPU usage—even for ProRes. And that's a good thing, because ProRes files can run really big! Here's a rough guide for choosing the right size drive.
  
   | **Codec**  | **Resolution** | **Size on Disk**         |
   | ---------- | -------------- | ------------------------ |
   | ProRes 422 | 1080p          | 1.02 GB/min = 61.2 GB/hr |
   | ProRes 422 | 720p           | 0.53 GB/min = 31.8 GB/hr |
   | ProRes 422 | 480p           | 0.36 GB/min = 21.6 GB/hr |
   
   <br/>
3. **Split files often.** Rather than saving a single five-hour file to disk, start/stop the file recording for each song, set, etc. Doing so limits inevitable dropped frames to a smaller percentage of the duration of the video, making audio drift less noticable and increasing the chance for multicam syncing.


### References

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
[^8]: Looks like public beta for the Blackmagic Intensity Shuttle USB 3.0 support started with [Desktop Video 9.7.3 on June 16, 2013](https://www.blackmagicdesign.com/support/readme/201836592e384a54a140e0bbfad03a63) but was [still in beta through May 28, 2014](http://forum.blackmagicdesign.com/viewtopic.php?f=11&t=22926) at least.
[^9]: Wirecast recommends always keeping the CPU under 80% <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=18511>
[^10]: Wirecast frame rate loss suggested around 85-90% CPU <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=19731>{:target="_blank"}
[^11]: This Wirecast post suggests frame rate loss one says 80% CPU <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=17012>{:target="_blank"}
[^12]: Another 80% CPU, also external HD very little impact on disk <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=16048>{:target="_blank"}
		<blockquote>
		Basically streaming and recording are using the same encoder rather than two encoders in that case.
		<br />...
		<br />CPU above 80% can result in problems. External hard drives have very little impact with overall CPU use.
		Apple ProRes is a professional post production codec. H.264 is generally not best for post workflow. It can take significant CPU resources to encode (and decode in post).
		</blockquote>
