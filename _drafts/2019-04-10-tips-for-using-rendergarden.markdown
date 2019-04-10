---
layout: post
title:  Tips for Using RenderGarden to Accelerate After Effects Renders
subtitle: 
date:   2019-04-10 12:09:52 Z
categories: rendering
---

* TOC
{:toc}
### Intro

Recently, I found myself deinterlacing footage from two BluRay discs using some Red Giant After Effects plugins. My jaw dropped when I saw the estimated time for just the first disc approach 50 hours. Plenty of CPU was available on the machine...

That got me searching for a way to multithread After Effects renders.

### Hello RenderGarden

RenderGarden is a neat way to chunk and multithread renders from After Effects. It invokes `aerender` which is a headless way of running After Effects. It costs $99 and comes with a 7 day trial.

In my case I had two computers (the MacBook Pro and the iMac) with the project files accessible via a Synology NAS. I installed After Effects on both machines, and procured render-only licenses from Red Giant via email (less than one business day).

### Things to Keep in Mind 🌼

RenderGarden's getting started videos are quite helpful and got me up and running in about an hour. Here is a summary of some things I additionally learned from experience. 

* A "seed" is an atomic unit of work. The number of seeds a composition is broken up into is set when generating the script files from After Effects. It cannot be changed afterwards.
* When a render is cancelled and later re-seeded/restarted, it does not pickup from where it left off. The file segment is overwritten and starts over from the beginning (the log file is appended to though).
* Sometimes segments complete and the log will say `Finished composition`, but the Terminal window itself hangs without writing `RENDER COMPLETE` in the logs. On some rare occassions, the filename also doesn't rename from `rendering_` to `complete_`.
* Before issuing CTRL+C for hung Terminal windows, check if the file needs to be renamed to `complete_` first. Otherwise another free node may overwrite the actually completed segment.
* Having the Recycle Bin feature on the Synology is helpful in the event of recovering accidentally deleted segements.
* If the Launch Gardener window doesn't appear after launching the app, it is probably hidden behind other windows. Use Expose to reveal it, or click on the Python launcher in the dock.
* The Launch Gardener window has four types of node types, which I couldn't find explanations of.
  * The `ae` node type is for actually running After Effects `aerender` in the background.
  * The `ffmpeg` node type is only used for post-processing conversion to H.264, etc. and the `combine` node is to combine segments together. This was slightly confusing at first because RenderGarden technically also uses ffmpeg to stitch movie segments together, as noted in the documentation.
  * The `notify` node type is for some type of notification system, which I didn't use.
* I find it best practice to only launch `ae` type nodes and wait for them all to complete before running `combine` nodes. That way I can inspect logs and file sizes before combining them.

### Performance Benchmarks

Since I was running renders on both the MacBook Pro (MBP) as well as the iMac, I was curious how the two would compare in terms of speed and CPU usuage. Both compositions (A and B) where seeded to eight segments.

The following table is sorted by End Time ascending. As you can see both the Quad Core iMac i5 and Quad Core MBP i7 MBP have a max throughput of 20 frames/minute.

I initially started with the RenderGarden recommendation of no more Gardeners than the number of physical cores, which in this case was four (for both machines). However I saw in iStat Menus on the MacBook Pro that there was still some idle CPU, so I added an additional fifth node. As shown below, the throughput drops to 13 frames/minute, which even with five processes is $100 - 13*5 / 20*4 = 20 $ percent slower.

| Comp | Seed | Machine | Frames   Start | Frames   End | Num   Frames | Elapsed   Mins | Frames/Min  | End   Time   | Graceful   End |
| ---- | ---- | ------- | -------------- | ------------ | ------------ | -------------- | ----------- | ------------ | -------------- |
| A    | 1    | MBP     | 0              | 11508        | 11509        | 570            | 20.19122807 | 4/5/19 1:14  | TRUE           |
| A    | 4    | MBP     | 34528          | 46037        | 11510        | 831            | 13.85078219 | 4/5/19 5:35  | TRUE           |
| A    | 5    | MBP     | 46038          | 57546        | 11509        | 824            | 13.96723301 | 4/5/19 5:38  | TRUE           |
| A    | 3    | MBP     | 23019          | 34527        | 11509        | 833            | 13.81632653 | 4/5/19 5:39  | TRUE           |
| A    | 2    | MBP     | 11509          | 23018        | 11510        | 847            | 13.58913813 | 4/5/19 5:52  | TRUE           |
| A    | 6    | MBP     | 57547          | 69055        | 11509        | 798            | 14.42230576 | 4/5/19 14:37 | TRUE           |
| A    | 8    | MBP     | 80566          | 92074        | 11509        | 794            | 14.49496222 | 4/5/19 18:55 | TRUE           |
| A    | 7    | MBP     | 69056          | 80565        | 11510        | 817            | 14.08812729 | 4/5/19 19:17 | TRUE           |
| B    | 3    | iMac    | 42560          | 63839        | 21280        | 1024           | 20.78125    | 4/6/19 5:34  | TRUE           |
| B    | 4    | MBP     | 63840          | 85119        | 21280        | 1498           | 14.20560748 | 4/7/19 1:43  | TRUE           |
| B    | 8    | MBP     | 148960         | 170239       | 21280        | 1575           | 13.51111111 | 4/7/19 3:01  | TRUE           |
| A    | 2    | MBP     | 11509          | 23018        | 11510        | 610            | 18.86885246 | 4/8/19 22:13 | TRUE           |
| B    | 2    | MBP     | 21280          | 42559        | 21280        | 1087           | 19.57681693 | 4/9/19 4:43  | FALSE          |
| B    | 1    | MBP     | 0              | 21279        | 21280        | 1104           | 19.27536232 | 4/9/19 4:59  | FALSE          |
| A    | 3    | MBP     | 23019          | 34527        | 11509        | 565            | 20.3699115  | 4/9/19 7:39  | FALSE          |
| A    | 1    | MBP     | 0              | 11508        | 11509        | 644            | 17.87111801 | 4/9/19 21:09 | TRUE           |
| B    | 7    | iMac    | 127680         | 148959       | 21280        | 998            | 21.32264529 | 4/10/19 3:11 | TRUE           |
| B    | 5    | MBP     | 85120          | 106399       | 21280        | 1021           | 20.84231146 | 4/10/19 3:25 | FALSE          |
| B    | 6    | MBP     | 106400         | 127679       | 21280        | 1082           | 19.66728281 | 4/10/19 4:27 | FALSE          |