---
layout: posts
title: "Mind Events"
isPost: true
date: 2013-11-20
preview: 1
---

There are ideas you run into in life that completely change your outlook or viewpoint about how you do certain things. When something challenges your worldview, there is a typical flow that happens:

1. Examine the challenge and compare it with your current view.  
2a. Your view stands up to scrutiny and the new view compliments or confirms what you believe.  
2b. Your view is found to have holes and the new view replaces or corrects your belief.  

Over the past year, a number of things have challenged my view of software design or of how certain software systems ought to be implemented. Some of these ideas are things I have either wrestled with in building these systems or are simply new ideas which require consideration in the systems I write. I wanted to catalog these things for my own sake as well as to spread the challenge on to others. 

## The Things Learned in 2013

### 1: NoCMS - Refocus Content Management on Content

We started to do a lot of evaluation of a number of differnet CMS systems and find that most of them focus on being a "do it all" type system. Content, layout, widgets, social integrations. It's meant to be a full site builder experience. But here's the kicker. CMS is meant to manage content, not design. If you're an agency, the clients _should_<sup>*</sup> be paying you to design both experience and interface for them. If you give them a do-it-all platform, they will, in fact, try to do it all. And doing it all tends to muck with your pretty content spaces, text overflows, images get shifted over top of other content, videos break, etc., etc. 

_<sup>*</sup>I say "should" because they usually pay you to take advice from them on how to do your job._

CMS is about giving the user the ability to change content, not the design or flow of that content. As an agency, you control the design and the user experience. That's what your client is paying you for. What you don't want to have to manage day-to-day is the minutia of updates to content, the client's whim to have the word "better" be changed to "good" or to add 6 more images to the carousel. Clients can do those things. But they shouldn't be able to affect the design or the experience. Otherwise, what are they paying you for? Giving the CMS user too much flexibility ultimately hurts their ability to care about quality content. 

There is much more here, but the main influencer of this change in thinking comes from Phil Hawksworth. His excellent [presentation](http://vimeo.com/53317254) on this topic is something I revisit often. The slides are [here](https://speakerdeck.com/philhawksworth/i-can-smell-your-cms) as well.

### Caching - Lessons from Twitter

In an article from the [High Scalability blog](http://highscalability.com/blog/2013/7/8/the-architecture-twitter-uses-to-deal-with-150m-active-users.html), they outline some of the amazing work Twitter as done to ensure that the fail whale stays confined to his watery grave. Timeline assembly, something I have only really done once, is a tricky problem. The queries required for these kinds of operations can be tricky, and generally complex and slow. According to HS, Twitter deals with "150 million users with 300 [queries per second] for timelines". Even with sharded databases, actually pulling in that much data takes time.

The solution is actually pretty elegant (I think). HS terms it "write based fanout approach". This means that timelines for users are constructed and added to when a tweet arrives at Twitter's services, rather than when a user requests it. Basically it computes the timelines on tweet ingest, placing it in the users' timelines to whom it belongs based on the rules of the Twitter game (followed/following, @reply rules, etc.). The fanout rate is slower, but ultimately, with clustered Redis, utilizing __terabytes__ of RAM as a timeline cache, the read speeds are pretty quick.

For us, we don't deal with anything nearly the scale of Twitter. But for projects that involve heavy data vizualization, Redis and the idea of precomputing on data ingest, rather than for each request, speeds up page load times pretty fantastically. Your data rarely has to be hyper-realtime.

## Static Sites are Awesome

Following on the heels of both the above two "mind events", I've found revisiting static sites as a very clean alternative to the always-generated on-the-fly sites with massive amounts of JS or async content loading. Sure, real-time apps are cool, but static is so fast and provides so many options for hosting in an easily scalable fashion, it almost outweights the cool factor of ultra-dynamic sites. Plus they don't have any big failure paths (failed AJAX requests, layout breakage, missing images, etc). You can publish static sites with very little supporting infrastructure giving you limitless options for hosting options. Heck, you could publish the whote site to a CDN and serve it from the edge right next door to your consumers. Combined with pre-computed data, you could even publish your dataset as a JSON blob alongside your site for non-sensitive data meaning there is no latency cost to roundtrip across the wire to get data. Your JS-driven, thick-client sites are no match for my static foo. 

And all this isn't to say you can't do some interactivity along with it. For the portions of the site (portions, not the whole damn cake), you can use lightweight EventSource or WebSockets to deliver data out of band, even faster than AJAX. We live in an incredible world of interactive technology for delivering content faster than ever before with less bandwidth cost than could have been imagined just a few years ago. Use it. But, as with anything, in moderation. Please.




