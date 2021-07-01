+++
title = ": Leela"
draft = false
date = 2011-09-25T07:53:43-04:00
showonlyimage = false
image = "img/work/leela/leela_header.jpg"
tags = ["videogame","wii","curious pictures"]
summary = "Breakdown of work done on Deepak Chopra's game Leela created for the wii and xbox."
weight = -20110925
[menu.work]
parent = "work_2011"
+++



{{< image src="/img/work/leela/leela_title_image.jpg" thumb="/img/work/leela/leela_title_image.jpg" caption="Leela video game opening menu graphic." >}}





[Leela](https://en.wikipedia.org/wiki/List_of_Wii_games) was a strange little creature of a production during a very busy time.

I think [Curious Pictures](https://en.wikipedia.org/wiki/Curious_Pictures) was trying to 'break into' the video game industry. It was the adolescence of the iphone get rich quick boom. Everyone wanted a piece of that new media market. There were many rags to riches stories in game titles and small startups at the time. The promise of creating content on this new and starved platform was too appealing to ignore. The risks till not widely known. How much time, energy and resources did it take to make a 'viral' game? How much was design and game play, vs graphics, vs in app purchases, or adds, etc. No one knew or was talking yet.

Curious had a legacy of gaming come to think of it. Curious' toy division had been the one section of the company that consistently turned predictable profits. Curious was also creating motion capture content for the Rockband games. I recall [Steve Oaks](http://www.imdb.com/name/nm1016099/) making some web and flash games back in the day (1998/99?). So maybe, it wasn't out of the blue as it seemed for the studio to be creating their own video games!

Anyway.
For me personally, I was super excited. We were going to be utilizing the new x-box Kinect and the Wii motion sensor. These were both new and exciting technologies. In essence, the gaming hardware allowed developers to accomplish real-time re-targeting of skeletons. That was a very bid deal at the time! In contrast we used the [Vicon](http://www.vicon.com/) Motion Capture system at Curious which utilized 24 highly specialized cameras costing 25k a piece! So for the Xbox and the Wii to accomplish a similar feat with a 250$ 'toy' was revolutionary.


My contributions to Leela were a bit superficial. At some point I got to assist [Marc Corotan](https://www.imdb.com/name/nm3155864/), CP's staff art director, in creating some level concept art (gallery below). Mostly though I remember helping work out some technical aspects of integrating Photoshop into the Curious Pictures pipeline. This would take the form of javascript code to export 'menu gui items' image assets for the game in a consistent manor. Having this large library of menu pictures named consistently a exported in a very special fashion was immensely important for the developers ([Mike Lang](https://www.imdb.com/name/nm4469721/) and [Steve Muniz](https://www.imdb.com/name/nm2618274) in house).


Concept art gallery:
{{< gallery2 "work/leela/gallery01">}}

---
Adobe at this point in the creative suit evolution had (for the first usable time) just finished forcefully ramming Javascript into Photoshop. This was the first phase of Adobe's effort to add 'pipline-abulity' to it's full production suit mirroring the success of Flash and Aftereffects. But the Photoshop API was inconsistent with the rest of the programs. It was buggy, and did not support the ability to create new (dock-able) panels or bind new commands to menu items or to hot keys via listeners. This new Photoshop pipeline api was both exciting and frustrating to work with. In the end, the interface for the artists was to manually load the pipeline javascript code each time they needed to run it. Which, as crazy as that sounds now, was actually way better than exporting hundreds of button-gui-states from photoshop layers into precisely named *.png files (correctly pre multiplied) on disk and then manually loading each one into the asset management system! Gross right? Thank goodness for the scripting.


In the end, I remember being taken off the project prematurely. [Lewis Kofsky](https://www.imdb.com/name/nm2572946) put me back on commercials after a few months. At the time, I didn't understand the pace of video games. Compared to the speed of commercials, creating assets for games was mind bogglingly slow. For instance, if you were commissioned to make a small color tweak to a button roll-over state.....an innocent and minor thing to be asked....required having to follow a laundry list of steps.

- 1. Check the asset(s) out of the database.
- 2. Make the tiny changes.
- 3. Export the asset.
- 4. Upload the asset to the database.
- 5. Have a developer load the asset into the latest working build (usually a test stage custom created to test the specific asset).
- 6. Take the rom over to the wii.
- 7. Load the game and 'playing' till you could test the asset being updated.
- 8. Hope the change is what you were hoping for.

At best this loop would take several hours, at worst several days. Can you imagine the pressure and tedious nature of that work? Make a small change while working mostly blind....wait several days for the results....then go mental.

I really did have a hard time getting into the flow of it. But, I think in retrospect, it had less to do with some presumed inherent nature of video game design and authoring....and likely more a reflection of my workload in 2011. Simply put, I was working too much back then. Running on adrenaline most likely. Waiting an hour for feedback on anything seemed insane to me. To the frustration of my boss Lewis, I wound up spending more time trying to figure out a solution to make the creative process faster than actually doing work. Which is likely why he gave me the marketing stills and visual game design work to do. It was a consuming creative task with no possibility of potential efficiency that would eat away at my focused energies:)
