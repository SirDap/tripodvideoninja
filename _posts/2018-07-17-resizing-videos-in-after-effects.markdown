---
layout: post
title: Resizing Video in After Effects with Red Giant Instant 4K
subtitle: Upconversion and RAM Struggles 
date: 2018-07-17 22:02:32 Z
categories: repair
---

*[Updated Sep. 16, 2018 with detailed After Effects walkthrough.]*

*[Updated Sep. 26, 2018 with fast-loading ProRes 422 picture and video samples.]*

* TOC
{:toc}
### Upconverting 480p Footage

This May, I tried something new and recorded an HD-source livestream to 480p ProRes 422 to help save on disk space/throughput.

All of the other raw, camera footage was in 1080p and I wondered if there was some way to "upconvert" the SD resolution footage. I especially needed to do so because some of the raw camera footage got corrupted, and the livestream was the way to salvage that angle.

### Instant 4K and After Effects

Despite the name, the **Red Giant Instant 4K** plugin is more like "Up to 4K." It's the latest version of their resizer plugin and is perfect for resizing to 1080p as well. From what I understand, the plugin uses some advanced interpolation algorithms to redraw each frame of the video as it expands it.

Instant 4K is part of Red Giant's Shooter Suite bundle and comes with plugins for Adobe Premiere and Adobe After Effects. I used After Effects CC 2018 plugin.

### A/B Video Comparison

"Seeing is believing."

Here's a before/after test. Both files were opened in QuickTime Player X, and the 480p window was stretched to the same size as the 1080p window.[^2] Below is a looping slideshow of them before/after (image cropped to make it easier to see).[^3]

Notice how the clarity of text and richness of color is preserved in After Effects render! This is *even with* the inherent compression in both screenshots.

<script>
function change_image() {
    var url = document.getElementById('Change_Image').src;
    if (url.includes("with-plugin")) {
        document.getElementById('Change_Image').src = "{% asset resizing-prores-original.png @path %}";
    } else {
        document.getElementById('Change_Image').src = "{% asset resizing-prores-with-plugin.png @path %}";
    }
}
setInterval(change_image, 800);
</script>
<img id="Change_Image" src="{% asset resizing-prores-original.png @path %}" />

If you have a 1080 display, here's another comparsion. Both videos are started in QT X together via ⌘+Enter and are toggled back and forth with ⌘+` (filename changes at the top). The screen capture was exported from Camtasia 2 as ProRes 4444 and compressed to H.264 by EditReady (visually lossless).

The greatest quality loss in the screen capture itself, but it's still a useful test. Real-world delivery formats will be compressed, after all!

If you're on a resolution smaller than 1920x1080, you'll probably be underwhelmed.

There's definitely more compression visible (for example in the color red), but even then there's a noticable difference in the clarity of the resized image!

<div class="videoWrapper">
<video controls width="640" height="360" preload="metadata" poster="{% asset resizing-prores-poster.png @path %}">
  <source src="{% b2 Instant4KPlugin-Before480After1080-H264.mov %}" type="video/mp4">
Your browser does not support the video tag.
</video>
</div>

Feel free to [download the raw ProRes 422 videos]({% b2 Wirecast-ProRes422-Resizing-Experiments.zip %}) to do your own comparisons too (190 MB).




### Plugin Workflow and Settings

1. Drag and drop the footage into After Effects
2. Right-click a video file and create a new composition from it
3. Right-click the composition and select **Composition Settings**. Change the **Preset** to the target resolution (e.g. **HDTV 1080 29.97** with **Square Pixels**). The source video should now be smaller than the canvas size. ![]({% asset after-effects-resize-settings-1.png @path %})
4. Use the **Effects & Presets** dropdown to find the **Red Giant Shooter Suite ** section. Drag and drop the `Instant 4K` plugin into the composition's viewer to apply. It should automatically resize to the canvas size!
5. Adjust the plugin settings as desired. I personally use **Filter Type Best, Sharpness 6, Quality 10, and Anti-aliasing 3**, based on Red Giant's Getting Started with Instant 4K video[^1].
6. Select the composition and choose **Composition > Add to Render Queue** from the menubar. Use **Render Settings > Best Settings** using the small drop down. ![]({% asset after-effects-resize-settings-2.png @path %})
7. Create a new **Output Module** to export to **ProRes 422**. ![]({% asset after-effects-resize-settings-3.png @path %})

For reference, the 17 second video clip earlier took 3 minutes and 43 seconds to export on the 2011 iMac with 12 GB of RAM. That is, **13x**!

### RAM Requirements

Resizing ProRes footage apparently can't be done on all machines. Here's why.

#### Are You Hongry for RAM?

Little did I know how incredibly RAM-intensive resizing footage is. This problem was particularly intensified by the sheer length of the video files: some were nearly 2 hours x 1 GB/min = 120 GB (classical music concert footage).

The 2011 MBP actually *ran out of RAM*. Like kaput. I tried a few things like increasing After Effect's memory allocation, etc. but it was all essentially the same. Anything larger than 30 minutes would crash. Queuing up multiple renders wouldn't work, because the program would need to be restarted before each one. The laptop was already maxxed out with 8 GB RAM.

![]({% asset after-effects-mbp-resize-crash.gif @path %}) 

This is when I remembered that nice desktop in the basement.

#### Return of the iMac

Unlike the MBP, the iMac has four RAM slots. Both machines had 8 GB total at the start, but the iMac impressively cranked out the footage. It would seem that somehow this older iMac is just more stable, perhaps by virtue of it being a desktop.

Eventually the iMac also started freezing up for the larger files. However after upgrading the machine to 12 GB—two 2 GB chips and two 4 GB chips—it was invincible.

#### Observations on RAM Pressure

One thing I noticed was even after a render is complete, After Effects typically still holds onto the RAM. Some of it can be purged by manually by selecting **Edit > Purge > All Memory & Disk Cache...** but it's my observation that the RAM is only released completely after closing the program. Exiting the program usually takes a while too, sometimes of upwards of 2 minutes as it slowly siphons the RAM back.

On the iMac with 12 GB RAM however, I had no trouble queueing up multiple renders.

### Footnotes
[^1]: Red Giant's video guide for the Instant 4K plugin <https://www.redgiant.com/tutorial/getting-started-with-instant-4k/>
[^2]: The 853x480 file could only be resized to 1920x1079 in QT X because of roundoff error. Hence the slight 1 pixel height difference when cycling between the two files.
[^3]: This slideshow is rendered with Javascript, and is not a GIF, in order to minimize compression losses.