---
layout: post
title:  "FCP X Now Unaffected by XMP Metadata"
subtitle: "Hello open tagging. Goodbye fear of broken media links!"
date:   2016-01-09 20:37:41 -0500
categories: codecs metadata
---
* TOC
{:toc}

There is quite a bit of literature[^1] [^2] [^3] [^4] [^5] on the net how Adobe applications can embed XMP metadata and modify original footage—wreaking havoc for other NLEs like FCP. Posts range as far back as 2011, the year FCP X was released, to even one in mid 2014.

The takeaway of all them, rightly so, was to uncheck the nasty _Write XMP ID to Files in Import_ setting in Adobe Premiere, After Effects, etc. so the original files remain untouched. Then, other NLEs like FCP X won't be affected and continue their merry way.

Turns out things have changed—for the better!

### Setup

The following experiment was conducted using the following:

* 15" Mid 2012 MBP 9,1
* OS X 10.11.1 El Capitan, released 2015-09-30[^6]
* FCP X 10.2.2, released 2015-09-04[^7]
* Adobe Premiere Pro CC 2015 9.1.0(174) Build "Original Gravity"[^8]
* XAVC-S 720p MOV file from a Sony AX100

### Procedure

1. Import video (as a linked file) into FCP X.
	![Sony XAVC-S MOV file imported into FCP X]({% asset_path fcp-xmp-initial-import.png %})

2. Use [ExifTool](http://www.sno.phy.queensu.ca/~phil/exiftool/) and save linked file metadata. Note the System File Date/Time values at the top.

		$ exiftool -api largefilesupport=1 -G1 XAVCS-sample.mov
		[ExifTool]      ExifTool Version Number         : 10.08
		[System]        File Name                       : XAVCS-sample.mov
		[System]        Directory                       : /Volumes/Scratch/est
		[System]        File Size                       : 3156 MB
		[System]        File Modification Date/Time     : 2014:05:22 03:25:30-04:00
		[System]        File Access Date/Time           : 2016:01:09 20:28:35-05:00
		[System]        File Inode Change Date/Time     : 2016:01:09 19:47:23-05:00
		[System]        File Permissions                : rwxrwxrwx
		[File]          File Type                       : MOV
		[File]          File Type Extension             : mov
		[File]          MIME Type                       : video/quicktime
		[QuickTime]     Major Brand                     : Apple QuickTime (.MOV/QT)
		[QuickTime]     Minor Version                   : 2005.3.0
		[QuickTime]     Compatible Brands               : qt
		[QuickTime]     Movie Data Size                 : 3307975773
		[QuickTime]     Movie Data Offset               : 48
		[QuickTime]     Movie Header Version            : 0
		[QuickTime]     Create Date                     : 2014:05:11 04:50:09
		[QuickTime]     Modify Date                     : 2014:05:11 05:31:53
		[QuickTime]     Time Scale                      : 600
		[QuickTime]     Duration                        : 0:41:43
		[QuickTime]     Preferred Rate                  : 1
		[QuickTime]     Preferred Volume                : 100.00%
		[QuickTime]     Preview Time                    : 0 s
		[QuickTime]     Preview Duration                : 0 s
		[QuickTime]     Poster Time                     : 0 s
		[QuickTime]     Selection Time                  : 0 s
		[QuickTime]     Selection Duration              : 0 s
		[QuickTime]     Current Time                    : 0 s
		[QuickTime]     Next Track ID                   : 3
		[Track1]        Track Header Version            : 0
		[Track1]        Track Create Date               : 2014:05:11 04:50:09
		[Track1]        Track Modify Date               : 2014:05:11 05:31:53
		[Track1]        Track ID                        : 1
		[Track1]        Track Duration                  : 0:41:43
		[Track1]        Track Layer                     : 0
		[Track1]        Track Volume                    : 100.00%
		[Track1]        Image Width                     : 1280
		[Track1]        Image Height                    : 720
		[Track1]        Graphics Mode                   : ditherCopy
		[Track1]        Op Color                        : 32768 32768 32768
		[Track1]        Compressor ID                   : avc1
		[Track1]        Vendor ID                       : Apple
		[Track1]        Source Image Width              : 1280
		[Track1]        Source Image Height             : 720
		[Track1]        X Resolution                    : 72
		[Track1]        Y Resolution                    : 72
		[Track1]        Compressor Name                 : H.264
		[Track1]        Bit Depth                       : 24
		[Track1]        Video Frame Rate                : 29.87
		[Track2]        Matrix Structure                : 1 0 0 0 1 0 0 0 1
		[Track2]        Media Header Version            : 0
		[Track2]        Media Create Date               : 2014:05:11 04:50:09
		[Track2]        Media Modify Date               : 2014:05:11 05:31:53
		[Track2]        Media Time Scale                : 44100
		[Track2]        Media Duration                  : 0:41:43
		[Track2]        Balance                         : 0
		[Track2]        Handler Class                   : Data Handler
		[Track2]        Handler Type                    : Alias Data
		[Track2]        Handler Vendor ID               : Apple
		[Track2]        Handler Description             : Apple Alias Data Handler
		[Track2]        Audio Format                    : mp4a
		[Track2]        Audio Channels                  : 2
		[Track2]        Audio Bits Per Sample           : 16
		[Track2]        Audio Sample Rate               : 44100
		[Track2]        Purchase File Format            : mp4a
		[Composite]     Avg Bitrate                     : 10.6 Mbps
		[Composite]     Image Size                      : 1280x720
		[Composite]     Megapixels                      : 0.922
		[Composite]     Rotation                        : 0
		$
3. Launch Premiere Pro. Enable the setting in Preferences to **Write XMP ID to Files in Import** which is now _off by default!!_
	![Enable Write XMP ID to Files on Import Setting in Premiere Pro]({% asset_path fcp-xmp-premiere-settings.png %})
4. Import the same clip into Premiere Pro.
	![Sony XAVC-S MOV file imported into Premiere Pro]({% asset_path fcp-xmp-premiere-import.png %})
5. Run [ExifTool](http://www.sno.phy.queensu.ca/~phil/exiftool/) again to confirm the file has been modified. Note how the System File Date/Time values are updated and the new XMP info at the bottom!

		$ exiftool -api largefilesupport=1 -G1 XAVCS-sample.mov
		[ExifTool]      ExifTool Version Number         : 10.08
		[System]        File Name                       : XAVCS-sample.mov
		[System]        Directory                       : /Volumes/Scratch/est
		[System]        File Size                       : 3156 MB
		[System]        File Modification Date/Time     : 2016:01:09 20:30:04-05:00
		[System]        File Access Date/Time           : 2016:01:09 20:30:22-05:00
		[System]        File Inode Change Date/Time     : 2016:01:09 20:30:04-05:00
		[System]        File Permissions                : rwxrwxrwx
		[File]          File Type                       : MOV
		[File]          File Type Extension             : mov
		[File]          MIME Type                       : video/quicktime
		[QuickTime]     Major Brand                     : Apple QuickTime (.MOV/QT)
		[QuickTime]     Minor Version                   : 2005.3.0
		[QuickTime]     Compatible Brands               : qt
		[QuickTime]     Movie Data Size                 : 3307975773
		[QuickTime]     Movie Data Offset               : 48
		[QuickTime]     Movie Header Version            : 0
		[QuickTime]     Time Scale                      : 600
		[QuickTime]     Duration                        : 0:41:43
		[QuickTime]     Preferred Rate                  : 1
		[QuickTime]     Preferred Volume                : 100.00%
		[QuickTime]     Preview Time                    : 0 s
		[QuickTime]     Preview Duration                : 0 s
		[QuickTime]     Poster Time                     : 0 s
		[QuickTime]     Selection Time                  : 0 s
		[QuickTime]     Selection Duration              : 0 s
		[QuickTime]     Current Time                    : 0 s
		[QuickTime]     Next Track ID                   : 3
		[Track1]        Track Header Version            : 0
		[Track1]        Track Create Date               : 2014:05:11 04:50:09
		[Track1]        Track Modify Date               : 2014:05:11 05:31:53
		[Track1]        Track ID                        : 1
		[Track1]        Track Duration                  : 0:41:43
		[Track1]        Track Layer                     : 0
		[Track1]        Track Volume                    : 100.00%
		[Track1]        Image Width                     : 1280
		[Track1]        Image Height                    : 720
		[Track1]        Graphics Mode                   : ditherCopy
		[Track1]        Op Color                        : 32768 32768 32768
		[Track1]        Compressor ID                   : avc1
		[Track1]        Vendor ID                       : Apple
		[Track1]        Source Image Width              : 1280
		[Track1]        Source Image Height             : 720
		[Track1]        X Resolution                    : 72
		[Track1]        Y Resolution                    : 72
		[Track1]        Compressor Name                 : H.264
		[Track1]        Bit Depth                       : 24
		[Track2]        Matrix Structure                : 1 0 0 0 1 0 0 0 1
		[Track2]        Media Header Version            : 0
		[Track2]        Media Create Date               : 2014:05:11 04:50:09
		[Track2]        Media Modify Date               : 2014:05:11 05:31:53
		[Track2]        Media Time Scale                : 44100
		[Track2]        Media Duration                  : 0:41:43
		[Track2]        Balance                         : 0
		[Track2]        Handler Class                   : Data Handler
		[Track2]        Handler Type                    : Alias Data
		[Track2]        Handler Vendor ID               : Apple
		[Track2]        Handler Description             : Apple Alias Data Handler
		[Track2]        Audio Format                    : mp4a
		[Track2]        Audio Channels                  : 2
		[Track2]        Audio Bits Per Sample           : 16
		[Track2]        Purchase File Format            : mp4a
		[XMP-x]         XMP Toolkit                     : Adobe XMP Core 5.6-c111 79.158325, 2015/09/10-01:10:20
		[XMP-xmp]       Create Date                     : 2014:05:11 04:50:09Z
		[XMP-xmp]       Modify Date                     : 2016:01:09 20:30:03-05:00
		[XMP-xmp]       Metadata Date                   : 2016:01:09 20:30:04-05:00
		[XMP-xmpDM]     Video Alpha Mode                : None
		[XMP-xmpDM]     Audio Sample Rate               : 44100
		[XMP-xmpDM]     Audio Sample Type               : Compressed
		[XMP-xmpDM]     Audio Channel Type              : Stereo
		[XMP-xmpDM]     Video Frame Rate                : 29.970030
		[XMP-xmpDM]     Duration Value                  : 1502300
		[XMP-xmpDM]     Duration Scale                  : 0.00166666666666667
		[XMP-xmpDM]     Video Frame Size W              : 1280
		[XMP-xmpDM]     Video Frame Size H              : 720
		[XMP-xmpDM]     Video Frame Size Unit           : pixel
		[XMP-xmpMM]     Instance ID                     : xmp.iid:f876396c-36cd-46bb-8e10-198ec05bf13c
		[XMP-xmpMM]     Document ID                     : xmp.did:0b184efa-54f1-404a-91a9-e1a5be69375d
		[XMP-xmpMM]     Original Document ID            : xmp.did:0b184efa-54f1-404a-91a9-e1a5be69375d
		[XMP-xmpMM]     History Action                  : saved, saved
		[XMP-xmpMM]     History Instance ID             : xmp.iid:4b09e22c-62ee-4df5-b4c0-c6ae3db78df7, xmp.iid:f876396c-36cd-46bb-8e10-198ec05bf13c
		[XMP-xmpMM]     History When                    : 2016:01:09 20:30:03-05:00, 2016:01:09 20:30:04-05:00
		[XMP-xmpMM]     History Software Agent          : Adobe Premiere Pro CC (Macintosh), Adobe Premiere Pro CC (Macintosh)
		[XMP-xmpMM]     History Changed                 : /, /metadata
		[Composite]     Avg Bitrate                     : 10.6 Mbps
		[Composite]     Image Size                      : 1280x720
		[Composite]     Megapixels                      : 0.922
		[Composite]     Rotation                        : 0
		$

6. Switch back to FCP X. No red media missing icon! Perhaps FCP X is working off the audio and video track lengths themselves, which did not change (as the ExifTool printouts showed).
	![Modified file still linked and scrubs in FCP X]({% asset_path fcp-xmp-great-success.png %})

### A Whole New World

While it'd be nice to know which version of FCP X finally became benign to embedded XMP metadata changes, the fact it now is unaffected by it opens a fresh range of possibilities for organizing footage and roundtripping between applications!

Some people wait a lifetime for a moment like this.

Indescribable feelings.

Hit the road, Jack!

### Resources

[^1]: [2011-08-15 Opening clips in Premiere Pro makes them go offline in FCX](https://forums.creativecow.net/thread/335/13900){:target="_blank"}
[^2]: [2012-07-17 Relinking this!](https://forums.creativecow.net/thread/344/13891){:target="_blank"}
[^3]: [2012-04-19 https://forums.creativecow.net/thread/344/19594](https://forums.creativecow.net/thread/344/19594)
[^4]: [2013-06-21 How to Transfer a Project from Final Cut Pro to After Effects](http://wolfcrow.com/blog/how-to-transfer-a-project-from-final-cut-pro-to-after-effects/)
[^5]: [2014-06-25 FCP X: Relinking Media [u] (see comment by SadMac)](https://larryjordan.com/articles/fcpx-relinking/#comment-24001){:target="_blank"}
[^6]: <https://en.wikipedia.org/wiki/OS_X_El_Capitan#Releases>{:target="_blank"}
[^7]: <https://en.wikipedia.org/wiki/Final_Cut_Pro_X#Evolution>{:target="_blank"}
[^8]: <https://en.wikipedia.org/wiki/Adobe_Premiere_Pro#Release_history>{:target="_blank"}
