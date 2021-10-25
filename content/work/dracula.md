---
title: "Dracula Untold"
draft: false
date: 2014-08-27T09:10:00-04:00
showonlyimage: false
image: "img/work/dracula/dracula_header.jpg"
tags: ["film","vfx","compositing","nuke","glow"]
summary: "Dracula Untold (2014), demo reel shots and descriptions."
menu:
  work:
    parent: '2014'
    weight: 20140827
    name: "Dracula Untold"
---


{{< youtube IuoXlhVkIx4 >}}

---


Ah, Dracula. Oddball show. Mostly because I don't recall much about it. Truth be told, I don't recall details of many shows after they are done. Little moments of passion I call them. The techniques are remembered, but once the production is completed and successful....my mind is usually on to the next fun puzzle. Is this a good thing or a bad thing? Who know. It's just the way it is.

Vladislav Akhtyrskiy was the comp sup and Christian Kaestner was the VFX sup. I was playing sequence lead I guess (I looked up my credit in the film). Mostly I was just solving little fun problems here and there. I think I composited more shots than in the video above....but I only put the biger ones I was sure of!

I have the vague memory of being on another show/production at Framestore and was brought on to help with the sword digidouble shots. The idea was to replace the practical plastic swords used on set with fancy shiny CG ones. The live action swords were pretty good actually. For being props that actors had to wield and not hurt eachother. I was impressed with what the prop department created. But, unfortunatly, the practical swords were just not shiny enough for the director. Also, because they were (safe) plastic, the swords tended to bend and deform in a cheesy way which took away from the scene.

The process that we created was to have the matchmove department 3D track (by hand!) the swords, while the paint a roto team removed the live action ones (when needed). Then the lighting team would generate CG swords and some specific passes. Finally in comp we would take the clean plates, CG swords and matchmoved geo to create the final images. It was a more complicated process in Nuke than I intended, but the results were nice. The artists had control to add novel reflections in 2D using the 3D sphere lookup pass (stmap), and the oversampling process for adding the micro scratches worked out well. The most fun was to place reflections of the actors into the swords which was needed on a few shots. To do that, we created a reverse 3D sphere lookup "tool" inspired by the Disney hair highlight placing setup they created for the animated film Tangled. It worked really well.


The last bit of fun I had on the show was to create a card based cloud volumes for the army running at the castle. In retrospect I should have created a plugin which did some simple path tracing through volumes. But deadlines being what they are, a bit of python code to generate cards and deep composite them into the CG army worked just fine. If the scene needed directional lighting the process would note likely have worked.
