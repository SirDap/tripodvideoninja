---
layout: post
title:  "Repairing Interlaced Footage Saved as Progressive"
subtitle: Waking up From an HDV-H.264 Nightmare
date:   2016-01-10 18:15:56 -0500
categories: 
---

We'll start with a quote from Larry Jordan:

> X.264 and H.264 should only be used when creating files for the web. If you plan to edit the resulting file, convert it to ProRes instead. AVCHD files compressed into H.264 for editing will look just awful.

Oops.

### The Rub
i made the mistake once (alright, two times) of recording HDV 1080i interlaced footage as progressive H.264. In an attempt to save on disk space and not use those awful MiniDV tapes, i had the brilliant idea of automatically saving to disk. ScopeBox always came to the rescue.

The only hiccup this time was: the same camera was to be used for livestreaming. It wasn't possible to share the video source with both Wirecast and ScopeBox, so i thought, "Hey, why not try recording straight to disk in Wirecast instead?"

Since HDV is technically a 4:3 1440x1080 image that's then stretched out, i wasn't sure whether i should record to 1920x1080 or 1440x1080. So instead, i said, let's just do H.264!

One major downside regardless, which i now realize, is Wirecast won't save timecode.

Rather than "upscale" to 1920x1080, i thought going 720p would be better—less loss of quality.

Thus the Nightmare Before the 2013 All-Night Concert began.


Notes:

2014: 11-5 @ 9:48 when flash is there, can see combs ...


### Appendix

#### Encoding Presets

Details of all the presets used. All audio settings left as default.

##### x264 Larry Jordan-esque (Compressor)

Inspired by: <https://larryjordan.com/articles/compressor-x264-improve-video/>

* QuickTime settings
	* Compression Type set to x264 Encoder
	* Key Frames set to Automatic (instead of Every 24 frames)
	* Data Rate set to Automatic (instead of 6400 kbps)
	* Encoding set to Best quality (Multi-pass)
	* Quality moved to High
	* Options ...
		* Flags > crf turned on. Everything else left as is
* Retiming quality set to Better (Motion Adaptive)

![]({% asset_path jordanx264-01.png %})
![]({% asset_path jordanx264-02.png %})
![]({% asset_path jordanx264-03.png %})
![]({% asset_path jordanx264-04.png %})
![]({% asset_path jordanx264-05.png %})
![]({% asset_path jordanx264-06.png %})
![]({% asset_path jordanx264-07.png %})

##### x264 Jan Ozer-esque (Compressor)

Inspired by: <http://www.streaminglearningcenter.com/articles/first-look-apple-compressor-41.html> and <http://www.streaminglearningcenter.com/articles/encoding-with-the-x264-codec-with-compressor-4.html>

* QuickTimeSettings
	* Set Compression Type to x264 Encoder
	* Options ... > Load preset > Use Library native preset/tune
		* x264 preset left as Medium (default)
		* x264 tune left as None
		* Hit OK
	* H.264 Profile limit left as up to High Profile
		* Hit OK
	* Changed Key Frames to Automatic
	* Compressor Quality to High
	* Encoding to Best quality (Multi-pass)
	* Data Rate set to Automatic (instead of 6400 kbps)
	* Hit OK
* Retiming quality set to Better (Motion Adaptive)

![]({% asset_path ozerx264-01.png %})
![]({% asset_path ozerx264-02.png %})
![]({% asset_path ozerx264-03.png %})
![]({% asset_path ozerx264-04.png %})
![]({% asset_path ozerx264-05.png %})
![]({% asset_path ozerx264-06.png %})
![]({% asset_path ozerx264-07.png %})
![]({% asset_path ozerx264-08.png %})

##### x264 Deinterlace (HandBrake)

* Started with High Profile
* Picture Settings > Filters
	* Deinterlace: Bob

![]({% asset_path hbx264-01.png %})
![]({% asset_path hbx264-02.png %})
![]({% asset_path hbx264-03.png %})

##### x264 Decomb (HandBrake)

* Started with High Profile
* Picture Settings > Filters
	* Decomb: Bob

![]({% asset_path hbx264-04.png %})
![]({% asset_path hbx264-05.png %})
![]({% asset_path hbx264-06.png %})

##### x264 Deinterlace, Top Field First (HandBrake)

* Started with High Profile
* Picture Settings > Filters
	* Deinterlace: Bob
* Add `:tff` under Additional Options

![]({% asset_path hbx264-07.png %})

##### x264 Decomb, Top Field First (HandBrake)

* Started with High Profile
* Picture Settings > Filters
	* Decomb: Bob
* Add `:tff` under Additional Options

![]({% asset_path hbx264-08.png %})

##### Apple ProRes 422 (Compressor)

* Started with stock preset
* Retiming quality set to Better (Motion Adaptive)

![]({% asset_path prores-01.png %})

##### Up to 4K (Compressor)
* Duplicate stock Up to 4K preset (can be found under either Publish to Vimeo or Publish to YouTube)
* Rename as H.264 for Archival
* Change Data rate from Web publishing (19531 kbps) to Computer playback (29296 kbps). Note rates are for actual 4K and are smaller for 720p footage.
* Change retiming quality to Better (Motion Adaptive)
* Change audio from AAC to Linear PCM 48kHz, Best Quality, 16-bit Little Endian (the Intel Default)[^2]

![]({% asset_path upto4k-01.png %})
![]({% asset_path upto4k-02.png %})
![]({% asset_path upto4k-03.png %})
![]({% asset_path upto4k-04.png %})

### References
[^] Tip to use `:tff` in Handbrake <http://stackoverflow.com/questions/9287122/how-do-i-set-the-interlaced-flag-on-an-mkv-file-so-that-vlc-can-automatically-pl
>
[^2] <https://larryjordan.com/articles/it-aint-the-endian-of-the-world/>
[^3] Frame rate loss around 85-90% CPU <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=19731&highlight_key=y&keyword1=record+to+disk>
[^4] This one says 80% CPU <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=17012&highlight_key=y&keyword1=record+to+disk>
[^5] Another 80% CPU, also external HD very little impact on disk <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=16048&highlight_key=y&keyword1=record+to+disk>
[^6] Recorded Interlaced Source as Progressive file - now what? <http://forum.telestream.net/forum/messageview.aspx?catid=45&threadid=23213&highlight_key=y&keyword1=deinterlace>