---
title: "Bladerunner 2049"
draft: false
date: 2017-12-29T14:49:13-04:00
showonlyimage: false
image: "img/work/bladerunner2049/bladerunner2049_header.jpg"
tags: ["VFX","film",'bladerunner2049','bladerunner','nuke','compositing']
summary: "Breakdown of sequences lead for the 2017 film Bladerunner 2049."
menu:
  work:
    parent: '2017'
    weight: 20171225
    name: "Bladerunner 2049"
---


{{< image src="/img/work/bladerunner2049/bladerunner2049_opening_title_graphic.jpg" thumb="/img/work/bladerunner2049/thumb_bladerunner2049_opening_title_graphic.jpg" caption="Bladerunner 2049 opening title card." >}}

---

By the numbers, Bladerunnder 2049 was likely the largest project / bit of work I'd personably been responsible for in my career. For better or worse. With the success of [Arrival](http://www.imdb.com/title/tt2543164/) and the excitement of the studio to be working with [Denis Villeneuve ](https://www.imdb.com/name/nm0898288/) once more, they were keen to give the director as many as the same Framestore crew as before. I was included in this mix.

I was hesitant at first when approached by the studio asking if I'd be interested in the compositing supervisor role for the film. A quick google search revealed it as one of the top 10 most anticipated films of 2017. Not only that, there was a legacy to uphold. The original film had an intensely loyal fan-base. It also seemed as if franchise 'reboots' were under public scrutiny in the last several years (maybe they always are?). The remake of a classic that is often referred to as a 'masterpiece' is a tall order. I was not confident I was the right man for the job. The VFX were going to require a mammoth amount of planning, new ideas, ingenuity, sensitivity and work.

Up until this point in my film career, I'd either worked on less marketed films, or was creating at the individual shot level, and could hide a bit from public scrutiny. By contrast this project, with 3 vendors.....and the world watching, everything we output was going to have to be better than perfect. This scared me a little bit. I'm a gentle, quiet person. The world doesn't seem to respond well to folks like that it seems. The idea of having a large crew frightened me. How would I handle the late nights that nearly drove me to a nervous breakdown on the [Barbie Diaries](http://www.imdb.com/title/tt0795338/) back in the day? What support systems could I put in place to fight my natural tendency to personally shoulder burdens or retreat into myself when stressed?


On this flip side, of course, I was excited for the project. It was an enticing idea to be a part of something potentially very memorable. Also I felt a bit of pride that my bosses thought I could handle it. Maybe as a first step towards trusting folks with my concerns, I could trust their confidence in me?

So I thought about it for several weeks. Made little meetings with many of my colleagues. Took notes about what didn't work currently, and in the past. Solicited the new innovations and production strategies they were playing with currently, or hoped to implement in the future. Then I re-read all the post mortems I'd kept from as many past shows I could find.

Feeling more confident after all this leg work, I accepted the gig.

Here was the basic strategy I wanted to try and use for the show:

For this fragile person to captain the ship, I was going to have to rely on the crew. So I decided to invest in people and not pipelines.
I knew from Fantastic Beasts that my personal limit for memorizing shots was around 150 or so. 70 was the comfort zone. On Bladerunner, we were producing 300+ shots. So, I needed a novel solution for that.

I figured, I could write all the fancy code I wanted to automate processes, but at the end of the day, it was going to be the individual artist who would have authority on shot work. It seemed common sense. Who would know better every pixel in an image? Me, the comp sup who looks at the shot for 15min while bidding, then 15 min 2x for temps, then 15x 3x to massage it to delivery.....for a average time of 1.5h per shot......or is it going to be the artist who is commissioned 6 weeks to bring the shot to final? It seemed a no brainer. The artists needed to be trusted. I needed to make for them feedback mechanisms to solve the creative challenges they discovered. My role would be to hold the big picture. To guide teams to develop good practices for sequence level continuity, provide critical feedback and set larger scale goals and deadlines.

To help solve this puzzle, I decided to rely on the age old 'sequence lead' position that we'd not used for several years at Framestore (because our Montreal shows were smaller while we built the studio up). Crossing this 150 shot threshold of mine, I wanted sequence leads. 1 lead per 100 shots if the work could be broken down that neatly. It was important also that I not create another level of approval for artists that would just slow production down. So, I needed the VFX sup and the sequence leads to work directly with the artists. And everybody needed to trust one another!

Armed with my research, and a plan, I went to the producer and asked her opinions on my 2D post production design.....She liked it! Being more experienced than me with large shot counts, she had some great advice and changes to make. Fundamentally, the sequence lead model is what we went with for the production design!

I was a bit sad to purposefully abstract myself off the production floor like that. I knew I would likely not directly interact with my peers as we used to. But it seemed the right move for the show. I guess, I desperately wanted to put a system in place where the people who were doing the work had the largest possible voice, and would be trusted in their skills. This plan, of giving the artists a team leader who they could get feedback from at a nearly constant basis seemed good.  Sometimes I would even miss dailies to establish how much responsibility I wanted production team and artists to trust the sequence leads with. We had a team of very talented compositors, and I didn't want anyone to get lost in a sea of shotgun notices, weekly targets, or having too many levels of management or numerous conflicting feedbacks. I wanted the creative and imagery to drive all our decisions.




---


Sapper's Farm House
------------------

[Jeremy Ducrocq](https://www.imdb.com/name/nm4130302/)  was the sequence lead for Sapper's Farm. Originally about 30% more shots in one of the earlier cuts that we recieved for bidding, the sequence was one of the more straight forward in it's own way. Set extensions, and CG buildings. There were some worms to animate. Many of the shots were very long which was problematic at 3.5k. Reviewing was troublesome as the caching systems we built for Gravity were mostly phased out in favor of faster network speeds. But with the scale of our source materials, and length of the shots. Often artists could wait 5-15min for the mastercomps to load off the disks. With the size of the studio we are, it was too little notice to rebuild the backend infrastructure for the film. Luckily the latest version of nuke we'd released to production allowed for the writing of EXR 2.0, enabling us to utilize DWA compression options. For a visually lossless quality the artists could render and preview the 1/3rd file size images and play back in real time. Then before submitting to dailies would make a propper zip1 compressed exr.

{{< gallery2 "work/bladerunner2049/gallery01">}}


---

DeNA Base
---------

[Adrien Nurse](https://www.imdb.com/name/nm3795077/)  took over Joi as her creative and technical lead at Framestore. Loads of time was spent on what would ultimately become a very subtle effect. The trouble with Joi's character in the film, was that without her, we would never get to experience and empathize with K's humanity. For the film to work, the audience needed to believe that Joi was possibly an AI, but also constantly reminded that she wasn't in fact real in the tangible sense. But, the effect could not be so gimmicy or obvious that the audience might think: 'How does Joi's technology work?' Any time spent thinking about how Joi's technology operated would be a distraction from K's journey.

From my point of view, Joi was one of the most difficult creative challenges I've witnessed in my career. Denis, Rodger, Richard, David, all spend the greater part of a year ironing out the details. It was a tremendous amount of collaboration that I think paid off. No matter how simple the effect may feel.

Adrien worked with the CG team to help iron out at Framestore many of the creative details that DNEG was also working on at the same time. The team he lead created all the various passes and processes that would allow for a focused group of compositors to complete all the Joi shots.

{{< gallery2 "work/bladerunner2049/gallery02">}}

---

Trash Mesa
-----------

[Andreas Karlsson](https://www.imdb.com/name/nm2404889/) was the sequence lead for the Trash Mesa sequence. Trash Mesa was a challenging sequence as there were a great number of shots (140+) that spanned a wide range of techniques. Digital Doubles. Explosions. Massive set extensions. Mountains of roto, and an endless amount of continuity. Again, all being produced at 3.5k and needing to be pixel perfect because it was Bladerunner.

{{< gallery2 "work/bladerunner2049/gallery03">}}


---

Penthouse - Joi
-------------

This was a small Joi sequence that Adrien Nurse took over. I don't think Framestore even finaled the shots as DNEG had to place snow outside the windows.....or all we did was the snow....something like that. These shots were bid later in the game, and taken away slightly as well. I sort of lost contact with these. But! As you can see. Joi's hologram effect is very subtle. It was complicated to make. Full body rotoscoping. Hairs and all. Then a full digi double created, and body tracks. Then we had a complicated system for rendering out Joi's interior 'shell' that could be slightly seen through her semi-transparent parts over bright backgrounds. It was a crazy amount of work.

{{< gallery2 "work/bladerunner2049/gallery04">}}



---


PilotFish - Drone sequence
--------------------------

[Luke Drummond's](http://www.imdb.com/name/nm0238576/) sequence. Originally I think this was conceived as an 11,000 frame shot or something like it. Ultimately they cut out large sections using the zooming effect as jump cuts of a sort. This was one of the biggest shots for us on the show, and likely had the largest total number of man days against it.
Interestingly, we struggled to make it look 'real'. We had a couple of things we were fighting.

One, was the speed of the drone. It was moving too fast. As some points I think it flies at mach 1 or something ridiculous.

Second was the scale of the world we were flying through. The Syd Mead style architecture is gigantic. Some buildings reaching over 4 miles tall in that scene. As humans we just don't have reference in our real lives right now. The buildings were so large in fact that any human scale details looks like sand.

Lastly, the whole scene was orange. Even the sydney sandstorm reference we looked at had more color.

To try and solve these creative issues, we tackled them one at a time.
1. Retiming animation to bring flight speeds down to normal (could not be done, as it would have resulted in a 35 min shot to cover the same distance)
2. Adding zoom effect to drone to be illustrate human scale objects from a wider scene.
3. Produced the shot in full color, pushing it to final approval level, then colorizing it.

This last step was likey the most important. It allowed the production team a way to validate all the effort and care put into the surfacing and light transports. We pulled the plug and even rendered full volumes for correct shadowing and reflections. It was the heaviest renders I've ever had the pleasure of being part of.

{{< gallery2 "work/bladerunner2049/gallery05">}}




---


Las Vegas - Statue Garden
---------

This was the first sequence turned over at Framestore for the film. Receiving these shots in fact before principle photography had completed. It was hard to vocalize the initial excitement I felt after reviewing the scans. The orange color of the photography.....that was done in camera! What?!?! It seemed unreal to me that a DP could get a producer to commit to that level of color on set when it could easily be done in post. But Rodger really wanted that look. He carried a carreer's worth of authority and by placing a filter on the lens, could ensure that his vision for the film would not be tampered with after the fact. It would be impossible for us to re-create the blue channel. There was no information to work with. The data was simply not there. As the first plates we recieved......it was fun to see what type of film this would be. A project where the director and DP were not scared to make bold choices, and likely had all the tools and expertise to back it up!
{{< gallery2 "work/bladerunner2049/gallery06">}}



---


Las Vegas - Penthouse
---------------------

The Penthouse was in also in Luke Drummond's assemblage of shots to lead. On set, [Rodger Deakens](https://www.imdb.com/name/nm0005683/) had convinced the studio to create a practical backdrop for principle photography. It was a massive 40 or 60 foot painting by 20 feet tall. Honestly, the thing was beautiful. The issue that came up was that on stage, it was a little tricky to hang and light. There were some waves in the fabric and some lighting hot/cold spots that needed to be massaged out in post.

Trouble was, that since there were no green screens, I had to ask my team to roto out every character and every hair on their heads, just to be able to accomplish the bit of touch up on the 'backing' (backing became our short hand for the backdrop touch up work). Painting out the fabric folds turned out to be difficult....so we had to restore and render the source digital scene that the art department used to print out and paint over. But that left us in a pickle. At this point, we had designed a post production workflow that resulted in full body hair accurate rotoscope for all set and characters....and we committed to a re-building the digital environment.....why not just replace all the windows with full cg and bypass the per-shot paint work, and continuity issues?

Well, for better or worse, after pitching the idea, Rodger didn't like a full CG replacement if it was going to look more or less like his plate photography. He was very concerned we would be tempted to 'over work' the shots. It seemed that the simplicity and stillness of the on set photography was something that he loved, and fought hard to get, and it was hard to not be inspired by his passion and genius. So we did the harder task and used the digital version of the onset backdrop to help with the paint effort.

{{< gallery2 "work/bladerunner2049/gallery07">}}

---


Las Vegas - Luv's Drone
-----------------------

These were a bunch of shots tossed our way more towards the end of the film. Luke Drummond lead them as they were similar to his other sequence. We were happy to take on the work even though being swamped by the sequences already in play. The CG team went above and beyond when creating the Las Vegas Environment asset. It was an impressive bit of work, and it was great to have another opportunity to show it off.
{{< gallery2 "work/bladerunner2049/gallery08">}}


---


Las Vegas - Penthouse Abduction
-------------------------------

Similar work to the Penthouse sequence. This had the added fun of explosions, muzzle flashes, and a crazy long multi-plate stich of a dog that wound up being more or less fully re-animated in comp at the end of the shot. It was fun to have a couple of spinner shots too. They were a real team moral booster in a film which was mainly 'invisible fx'.
{{< gallery2 "work/bladerunner2049/gallery09">}}


Theatrical credits
------------------

And the credits! It was a fun moment to see all our names on the big screen. In total, I spent about 1 year working on the film. Longer if I count the meetings and creative not billed before the show officially begins. Taking that into account, then the total time I spent on Bladerunner would be closer to 1.5 years realtime. It might be the longest I've been involved in a film to date?!? Who knows.
{{< image src="/img/work/bladerunner2049/BLADE_RUNNER_2049.framestore.theatrical.credits.jpg" thumb="/img/work/bladerunner2049/thumb_BLADE_RUNNER_2049.framestore.theatrical.credits.jpg" caption="Bladerunner 2049 Framestore Theatrical Credits." >}}
