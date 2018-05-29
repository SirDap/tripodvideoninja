---
layout: post
title:  "Best Practices for Large Web Transfers"
date:   2017-03-14 13:10:20 -0500
categories: 
---
* TOC
{:toc}

### The Challenge

Sometimes, when collaborating on projects virtually, file storage becomes a problem. Professional studios can probably run highly performant SFTP servers or bucket storage systems, but when you're working with other freelancers on tight budgets—who may not be as tech savvy—a 30 GB file starts becoming a big problem.

### Free, Simple File Sends

[Filemail.com](https://filemail.com){:target="_blank"} is a really convenient web service that allows for sends of up to 50 GB at a time in their free tier. Receipients can either download files in the web browser or can torrent them for convenient pause/resumes.

Filemail is typically the service I've asked others to send me raw video files through.

And I always ask the files be zipped up *first*... why?

### Repairing HTTP Header Corruption

One time, a person sent raw MTS (MPEG Transport Stream) video files from an AVCHD camera.  I did ask them to zip it up first, but for whatever reason that was overlooked. "How bad could it be?" I thought. I'd already downloaded about 40 GB of footage!

I fired up [Edit Ready](https://www.divergentmedia.com/editready) to rewrap the MPEG-2 Transport Stream into a MOV container for editing. However, the conversion would keep failing after a certain point...

I reached out the main man of Divergent Media, Colin McFadden, and he replied back super promptly with the following:

>	At that point in the file where it fails, there's a hunk of HTTP header, which definitely shouldn't be in an MTS file.  Seems like something went really wrong in however these were transferred.

Sure enough, there was some `Content Disposition` HTTP headers slapped in between!

![]({% asset mts-header-1.png @path %})

Deleting these with a hex editor and rewrapping the new file did the trick beautifully!

Interestingly (and this could very well be my own error) not all the headers were the same length: 444 bytes, 428 bytes, 456 bytes, and 453 bytes. Screenshots of the other three are below.

![]({% asset mts-header-2.png @path %})
![]({% asset mts-header-3.png @path %})
![]({% asset mts-header-4.png @path %})

### Always Zip

Take home lesson? Always ask files to be zipped before sending through web upload services. Compression isn't important really—storage-only zips or tars would do just fine.

And to salvage footage, don't be afraid to open a hex editor!