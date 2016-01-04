---
layout: post
title:  "How to Read XAVC-S XML Files for FPS Info"
date:   2016-01-03 18:15:56 -0500
categories: livestream hdv
---

Many new Sony video cameras (like the [FDR-AX100](http://www.sony.com/electronics/handycam-camcorders/fdr-ax100) and [HDR-CX900](http://www.sony.com/electronics/handycam-camcorders/hdr-cx900)) record into the new XAVC-S format. XAVC-S writes to mp4 container files, and along side them sit nice little XML files with metadata.

The AX100 has three FPS settings when recording to the XAVC-S HD file format (60p, 30p and 24p) and two when recording to XAVS-S 4K (30p and 24p). Turns out the FPS information is tucked away in the XML file quite neatly! 

Interestingly, the bitrate which differentiates XAVC-S HD (50 Mbps) and XAVC-S 4K (60 Mbps) is not present in the clip XML. It is however present in `M4ROOT/MEDIAPRO.XML` file!

To test this i took 5 shots:
* XAVC-S HD, 60 fps
* XAVC-S HD, 30 fps
* XAVC-S HD, 24 fps
* XAVC-S 4K, 30 fps
* XAVC-S 4K, 24 fps

### MEDIAPRO.XML
Summary of all files and their bitrates. Note how `@L41` and `@L42` indicate 50 Mbps and `@L51` 60 Mbps, or so it seems.

~~~
<?xml version="1.0" encoding="UTF-8"?>
<MediaProfile xmlns="http://xmlns.sony.net/pro/metadata/mediaprofile" createdAt="2016-01-03T06:10:17-04:00" version="2.10">
	<Properties>
		<System systemId="784B87FFFEBA9815" systemKind="FDR-AX100" masterVersion="XAVC-M4@1.10.00"/>
		<Attached mediaId="1EEAD341907305C09815784B87FFFEBA" mediaKind="AffordableMemoryCard" mediaName=""/>
	</Properties>
	<Contents>
		<Material uri="./CLIP/C0001.MP4" type="MP4" videoType="AVC_1920_1080_HP@L42" audioType="LPCM16" fps="59.94p" dur="210" ch="2" aspectRatio="16:9" offset="0" umid="060A2B340101010501010D43130000004E41F241907305CE784B87FFFEBA9815" status="OK">
			<RelevantInfo uri="./CLIP/C0001M01.XML" type="XML"/>
			<RelevantInfo uri="./THMBNL/C0001T01.JPG" type="JPG"/>
		</Material>
		<Material uri="./CLIP/C0002.MP4" type="MP4" videoType="AVC_1920_1080_HP@L41" audioType="LPCM16" fps="29.97p" dur="165" ch="2" aspectRatio="16:9" offset="0" umid="060A2B340101010501010D431300000008DF1242907305DF784B87FFFEBA9815" status="OK">
			<RelevantInfo uri="./CLIP/C0002M01.XML" type="XML"/>
			<RelevantInfo uri="./THMBNL/C0002T01.JPG" type="JPG"/>
		</Material>
		<Material uri="./CLIP/C0003.MP4" type="MP4" videoType="AVC_1920_1080_HP@L41" audioType="LPCM16" fps="23.98p" dur="120" ch="2" aspectRatio="16:9" offset="0" umid="060A2B340101010501010D4313000000A00A2242907305C0784B87FFFEBA9815" status="OK">
			<RelevantInfo uri="./CLIP/C0003M01.XML" type="XML"/>
			<RelevantInfo uri="./THMBNL/C0003T01.JPG" type="JPG"/>
		</Material>
		<Material uri="./CLIP/C0004.MP4" type="MP4" videoType="AVC_3840_2160_HP@L51" audioType="LPCM16" fps="29.97p" dur="105" ch="2" aspectRatio="16:9" offset="0" umid="060A2B340101010501010D4313000000AEA46349907305C9784B87FFFEBA9815" status="OK">
			<RelevantInfo uri="./CLIP/C0004M01.XML" type="XML"/>
			<RelevantInfo uri="./THMBNL/C0004T01.JPG" type="JPG"/>
		</Material>
		<Material uri="./CLIP/C0005.MP4" type="MP4" videoType="AVC_3840_2160_HP@L51" audioType="LPCM16" fps="23.98p" dur="84" ch="2" aspectRatio="16:9" offset="0" umid="060A2B340101010501010D4313000000B0398149907305CE784B87FFFEBA9815" status="OK">
			<RelevantInfo uri="./CLIP/C0005M01.XML" type="XML"/>
			<RelevantInfo uri="./THMBNL/C0005T01.JPG" type="JPG"/>
		</Material>
	</Contents>
</MediaProfile>
~~~

### XAVC-S HD, 60 fps
`tcFps="30" halfStep="true"` indicates 60 fps (i.e. 30 halved)

~~~
<?xml version="1.0" encoding="UTF-8"?>
<NonRealTimeMeta xmlns="urn:schemas-professionalDisc:nonRealTimeMeta:ver.2.00" xmlns:lib="urn:schemas-professionalDisc:lib:ver.2.00" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" lastUpdate="2016-01-03T06:10:57-04:00">
	<TargetMaterial umidRef="060A2B340101010501010D43130000004E41F241907305CE784B87FFFEBA9815" status="OK"/>
	<Duration value="210"/>
	<LtcChangeTable tcFps="30" halfStep="true">
		<LtcChange frameCount="0" value="40000000" status="increment"/>
		<LtcChange frameCount="209" value="54830000" status="end"/>
	</LtcChangeTable>
	<CreationDate value="2016-01-03T06:10:57-04:00"/>
	<Device manufacturer="Sony" modelName="FDR-AX100" serialNo="1234567890"/>
	<RecordingMode type="normal" cacheRec="false"/>
</NonRealTimeMeta>
~~~


### XAVC-S HD, 30 fps
`tcFps="30" halfStep="false"` indicates 30 fps (i.e. 30 divided by 1)

~~~
<?xml version="1.0" encoding="UTF-8"?>
<NonRealTimeMeta xmlns="urn:schemas-professionalDisc:nonRealTimeMeta:ver.2.00" xmlns:lib="urn:schemas-professionalDisc:lib:ver.2.00" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" lastUpdate="2016-01-03T06:11:40-04:00">
	<TargetMaterial umidRef="060A2B340101010501010D431300000008DF1242907305DF784B87FFFEBA9815" status="OK"/>
	<Duration value="165"/>
	<LtcChangeTable tcFps="30" halfStep="false">
		<LtcChange frameCount="0" value="40000000" status="increment"/>
		<LtcChange frameCount="164" value="54050000" status="end"/>
	</LtcChangeTable>
	<CreationDate value="2016-01-03T06:11:40-04:00"/>
	<Device manufacturer="Sony" modelName="FDR-AX100" serialNo="1234567890"/>
	<RecordingMode type="normal" cacheRec="false"/>
</NonRealTimeMeta>
~~~

### XAVC-S HD, 24 fps
`tcFps="24" halfStep="false"` indicates 24 fps

~~~
<?xml version="1.0" encoding="UTF-8"?>
<NonRealTimeMeta xmlns="urn:schemas-professionalDisc:nonRealTimeMeta:ver.2.00" xmlns:lib="urn:schemas-professionalDisc:lib:ver.2.00" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" lastUpdate="2016-01-03T06:12:00-04:00">
	<TargetMaterial umidRef="060A2B340101010501010D4313000000A00A2242907305C0784B87FFFEBA9815" status="OK"/>
	<Duration value="120"/>
	<LtcChangeTable tcFps="24" halfStep="false">
		<LtcChange frameCount="0" value="00000000" status="increment"/>
		<LtcChange frameCount="119" value="23040000" status="end"/>
	</LtcChangeTable>
	<CreationDate value="2016-01-03T06:12:00-04:00"/>
	<Device manufacturer="Sony" modelName="FDR-AX100" serialNo="1234567890"/>
	<RecordingMode type="normal" cacheRec="false"/>
</NonRealTimeMeta>
~~~

### XAVC-S 4K, 30 fps
`tcFps="30" halfStep="false"` indicates 30 fps, same as before

~~~
<?xml version="1.0" encoding="UTF-8"?>
<NonRealTimeMeta xmlns="urn:schemas-professionalDisc:nonRealTimeMeta:ver.2.00" xmlns:lib="urn:schemas-professionalDisc:lib:ver.2.00" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" lastUpdate="2016-01-03T06:52:49-04:00">
	<TargetMaterial umidRef="060A2B340101010501010D4313000000AEA46349907305C9784B87FFFEBA9815" status="OK"/>
	<Duration value="105"/>
	<LtcChangeTable tcFps="30" halfStep="false">
		<LtcChange frameCount="0" value="40000000" status="increment"/>
		<LtcChange frameCount="104" value="54030000" status="end"/>
	</LtcChangeTable>
	<CreationDate value="2016-01-03T06:52:49-04:00"/>
	<Device manufacturer="Sony" modelName="FDR-AX100" serialNo="1234567890"/>
	<RecordingMode type="normal" cacheRec="false"/>
</NonRealTimeMeta>
~~~

### XAVC-S 4K, 24 fps
`tcFps="24" halfStep="false"` indicates 24 fps, same as before

~~~
<?xml version="1.0" encoding="UTF-8"?>
<NonRealTimeMeta xmlns="urn:schemas-professionalDisc:nonRealTimeMeta:ver.2.00" xmlns:lib="urn:schemas-professionalDisc:lib:ver.2.00" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" lastUpdate="2016-01-03T06:53:28-04:00">
	<TargetMaterial umidRef="060A2B340101010501010D4313000000B0398149907305CE784B87FFFEBA9815" status="OK"/>
	<Duration value="84"/>
	<LtcChangeTable tcFps="24" halfStep="false">
		<LtcChange frameCount="0" value="00000000" status="increment"/>
		<LtcChange frameCount="83" value="11030000" status="end"/>
	</LtcChangeTable>
	<CreationDate value="2016-01-03T06:53:28-04:00"/>
	<Device manufacturer="Sony" modelName="FDR-AX100" serialNo="1234567890"/>
	<RecordingMode type="normal" cacheRec="false"/>
</NonRealTimeMeta>
~~~
