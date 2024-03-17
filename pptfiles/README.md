https://www.youtube.com/watch?v=9-_VPIu6zLw

0:00 we're going to
0:27 talk about how to contribute to docs microsoft uh show you the uh the the methods we
0:33 use the tools we use and so on and how you can help us out my name is sean wheeler i'm the lead
0:39 content owner for the powershell dock set itself
0:44 and i have with me mike and
0:50 uh you you may remember him more like this from years past so
1:01 [Laughter]
1:06 and these slides are available on the summit github
1:12 summit materials github we've got our github aliases and our email up there
1:19 you can contact us actually we'll have an update with our twitter handles on here as well
1:28 oh yeah he's got the updated version we we made the edits too
1:34 um [Laughter] so
1:41 talking about why you should contribute this contributing to docs is a much easier way
1:47 to contribute back to powershell without having to get into the the weeds of the code
1:54 if if the c-sharp scares you like it does me
1:59 this is a much easier way to do it and it helps improve the documentation for everyone
2:05 and again this is a great way to get recognition from the community there's some things i'll show you about what how
2:11 we recognize the community and if you're new to github and markdown
2:17 this is a great way to learn that as well
2:23 so this is going to be demo heavy we've got a few slides we're going to show
2:29 mostly uh the slides will be here so you have easy access to these links
2:35 um let me and just going back to the github and
2:41 the markdown cell so it's really skills you need for other things so like me when i was at my company i was the only
2:47 one contributing to a github repo so it's like how do i work with a team well
2:52 to learn those skills you can contribute to docs which is kind of a low a lot lower learning curve
2:58 and then if you want to even if you're blogging if you're posting say on github pages or hugo or jekyll you're going to
3:04 use the same workflow for your stuff and like me at my previous job i didn't have
3:10 uh somebody to to look at my code like a code reviewer so it'll give you uh i blog for free
3:16 code reviews hey just post your stuff on reddit but anyway this will give you a chance to have somebody with your mark
3:22 down and and so on in your writing skills to kind of to kind of take a look and say hey you
3:27 know do it this way instead of this other way and these are the reasons yeah and so the process we're going to show
3:34 you we have all this documented out on docs.microsoft.com this is the public
3:40 contributor guide and everything we're going to show you here
3:46 is how to contribute to anything on docs.microsoft.com not just powershell
3:52 we're going to talk to you about some of the specific things for powershell as we go through this but this walks you
3:58 through how to get set up with the tools if you don't have a github account already first of all
4:05 i think most everybody who uses github okay
4:11 so we we probably don't have to spend a lot of time explaining that
4:16 and we certainly recommend doing the full workflow which is going to be part of our demo
4:24 we also have out here these writing essentials guides where
4:29 there's the reference to markdown and we have some uh specific things
4:36 in our publishing platform some markdown extensions uh like these alerts
4:42 so there's some special markup that we use in docs like this that create these alert boxes
4:50 so this is non-standard markdown but we have it documented here
4:55 so this is a good reference on the markdown we use and then there's
5:01 information here about style and voice and writing principles
5:07 and a good way to get started after me and before i joined microsoft
5:14 and started writing docs for them you look at their github repo and it's like what's that crap you know just not walk
5:19 down some stuff on top of markdown that renders in their engine so if you look at it in markdown it doesn't render
5:25 properly and then we uh we use relative links a lot of times because that allows our docs to work in
5:32 like an air gap uh environment so if you go to github a lot of the links are open it's like hey what's the
5:38 deal guys but they render properly on our platform yeah
5:43 and because for like government clouds the air-gapped environments we
5:48 publish those docks in there and if we were linking to docs.microsoft.com
5:56 directly the air gap clouds wouldn't be able to get there with relative links they get
6:01 published in a way that will work for the air gap clouds and then we have in the power shell
6:09 dock set we have another contributor's guide here that gives you the specifics for
6:15 powershell and we'll get this in a little more detail as we go through
6:21 uh so let me see where we are i will say so we've got some conflicting information you'll look at the first one
6:27 that sean showed and it'll say do something a certain way maybe uh
6:32 to do italics i think this was the example we looked at yesterday and their dogs they do it one way and our doc our
6:38 contribution guide says do it another well of course we always win so uh so if we if there's anything
6:45 conflicting use the contribution guy that's closest to that documentation
6:50 right it's just like any open source project follow the style of that project
6:57 for any contributions you make and like in markdown right there's how many
7:03 different ways can you do bullets how many different ways can you do italics uh you can use the asterisks or the the
7:10 underscores we've decided asterisks is bold and underscores as italics and that
7:18 shows us the author's intent of what the the markup they in they meant to use
7:24 there's no mistakes so
7:29 of course there's always exceptions to that rule so we've you can use of course tildes which we don't use we use
7:35 backticks for like the the code blocks but if you want to show somebody how to
7:41 write it and you're going to put the backfix inside there so they can actually see it then you would need to use the tildes on the outside
7:50 so before we get into making a simple change let's talk about
7:57 the docs how many people use docs on a regular basis some things you might have noticed
8:04 there were some recent changes made they moved
8:09 these links here and they've changed the right hand navigation so if you go
8:16 into a larger article
8:24 you'll see this is expandable now they don't show the whole navigation
8:29 this is something they're testing out we've had some feedback that people don't necessarily like this
8:37 and you know feel free to give feedbacks to the docs platform folks about that
8:43 um i'm one of them i don't i don't care for this myself i personally like it because if i
8:49 want to know something about installing on a previous version that was linked there it's kind of an outline of the chapter i can click on that link and bam
8:56 in that section yeah but uh so one of the there's a couple changes
9:02 they made they they collapse it so you don't see the whole thing and
9:07 it's no longer pinned to the top of the screen so it scrolls off the page and you have to
9:13 go back but just realize right now this is uh like a 30-day trial and they're going to
9:19 get feedback and there'll be more changes coming
9:25 some other stuff i want to make sure people understand about our docs so we have two levels of navigation here
9:32 the top level here is the doc's site itself so you want to
9:39 go to some other major doc set you can start back at the root of docs and drill down from there
9:46 we have this level 2 navigation that's all powershell and then the docs set itself with the
9:52 table of contents we have this version picker here and
9:57 this switches between the documentation for the version of powershell that you're working on we get a lot of issues
10:05 that get filed with us that says well this parameter doesn't exist on this command or
10:11 whatever and they're looking at the documentation for seven two
10:16 but they're using five one so
10:21 uh always be sure you're you're selecting the correct version there what the version says also if you see
10:27 the url you can see it at the top it's got 7.2 on the end mr virgin moniker so it kind of tweaks the end of the url but
10:34 my recommendation even if you're writing a blog article and linking to it is don't put the url on that you specifically need it and you'll always
10:42 or the version the version monitors you'll always get the latest version if you don't put a version on it yeah that
10:48 way if the version goes away a lot of times usually we redirect those and you get a
10:53 nasty message at the top the other thing i would recommend is we translate our content in different cultures so if you
10:59 take the en us out and if somebody's in another country they'll get their local language
11:05 yeah the animal on back end just like branches or something how do you handle
11:10 all those different versions uh well yeah a good question
11:15 uh we'll show you in the repo how this is structured and it's just folders
11:21 um uh more about here so
11:28 also the thing to realize you see you can barely see it in the light of this room but there's a line here between
11:35 reference and the rest of the table of contents so everything above the line
11:42 is we call conceptual content and that does not in in this dark set that does
11:48 not change when you change the version moniker everything below the line
11:54 is commandlet reference so if i expand this out you'll see all the modules and then you can drill
12:01 in and see the commandlets this is what changes when you change the version selection
12:08 and at least in my box yeah they all change perversion yeah and it's not a sophisticated system if
12:15 if we had version conceptual content we'd have to duplicate it for every version
12:21 so obviously we don't want to have to maintain all of that for all that conceptual content
12:28 um also the other thing to note that uh everything below the line here is we
12:33 call auto-generated we have tooling that helps us create the markdown and publish
12:38 the markdown and it builds this part of the table of contents everything above the
12:44 line we have to hand craft that table of contents
12:50 um now so uh there's there's several ways
12:57 to make a contribution if you uh at the top of every article there's this
13:03 edit icon the pencil you click on that and that will take you to
13:08 github for that article and you can click the edit button here
13:15 and submit your changes that you're interested in or you can go
13:22 to the issues and file an issue and if you have it for this repo when you click on the edited action course
13:28 the refill and creates the branch for you but the other day i was on a repo that i hadn't previously bought and i
13:34 noticed on my github profile it said i i uh created a repository and i'm like
13:39 what i think yeah it does and that's seamless so for a simple change i just saw one of the
13:44 pm's this week doing his changes this way because it's like a one-line change
13:50 um in our issues it's always a good idea if you see an issue
13:58 to come check uh to see if the issue's been filed already and
14:04 for the powershell docs repo i have several
14:10 i should zoom this up a little bit issue templates that help uh help you
14:16 fill out and provide the information we need so choose the most appropriate one here
14:21 that's one point for sean who calls that someone to be with
14:26 yeah this is using the new yaml issue templates so
14:32 they're a lot easier to fill out and there's required information here so
14:37 if you if you haven't provided the required information you can't submit the great thing about that you don't
14:43 have to put the eggs in the stupid little box and then backspace so there's a night of space otherwise it breaks it
14:48 so this is really slick and even on your own replays or your personal projects that's a great idea
14:56 ah let's see where we are
15:02 so i think we've covered that oh yeah and then for the powershell docs we publish
15:10 any changes that have been made during the day get pushed to our live branch which publishes it to the website
15:17 um at 3 p.m pacific so if you've submitted a change and
15:22 we've merged it you just need to wait until it goes live to see it on the website
15:28 um there was something else i was gonna
15:35 we'll go ahead for the azure powershell dog structure we uh we actually have a couple of
15:41 repositories the and i've recently actually added the button at the bottom of the pages
15:47 so that you can submit an issue on the reference documentation and just to be
15:52 clear if you're not sure what reference documentation is that's the commandment held so for all that all the stuff you
15:58 would run get help that's considered reference documentation and conceptual documentation is more like quick starts
16:05 and tutorials and that sort of stuff but the source code for the azure
16:10 powershell content resides in the same repo as the source code
16:17 and what happens every time we release a new update which is generally on the first tuesday of the month
16:23 they uh they create a uh a build and they actually push that over to the docks
16:29 repo uh and what that means is so currently i think we're really 7.50 this week
16:35 so if you if you actually went out and submitted a contribution on 7.5.0
16:40 hey it would go live we we publish twice a day every in the mornings and afternoons every day
16:47 and it would be fine and then when we publish 760 next month the bug you fix would be back and you'd
16:53 be like what's the deal well the problem is you have to update the one that's the source version in
17:00 order to control future versions of the documentation so you've basically got current versions kind of like he was
17:06 showing in the version moniker so you could potentially have to update
17:12 like currently we have 660 we have 7 4 0 and seven five zero documentation and
17:19 then you have the source version so the azure stuff is a lot more complicated and if you do want to make a
17:24 contribution feel free to thank me and uh we can actually do a teams meeting or something and i can show you
17:30 the specifics but anyway there's multiple versions and we're going to be demonstrating beyond compare which is an easy way to get your
17:37 dots updated yeah and the other thing about
17:42 his content here the edit button will take you to the right version so here i'm on a conceptual document the
17:49 stuff above the line and when you go there you end up in the
17:55 docs repo not the source code repo but if we go
18:02 down here to reference and just pick something
18:08 and click on the edit
18:13 when button says edit i want you to notice at the top of the file down at the bottom the bottom of the screen there's
18:19 actually a little bit of metadata at the very top of the file that holds it to the right repo right if you're curious
18:25 about where this resides you can look at that dock in the metadata and find out
18:30 whenever sean goes back one thing i want to make sure that we do show that we haven't planned is if you scroll away to the bottom of
18:37 this show the two buttons on how to submit it oh yeah okay well
18:43 um well i have it turned on in mine so at the bottom of every page there'll
18:48 be uh two buttons here there's feedback for the product and so if you click uh the this product
18:55 button in my docset it goes to the powershell source code repo
19:01 and you can file issues there and then this page it takes you to the docs repo
19:07 to file an issue there when you when you do this for
19:15 feedback on this page it will open a new issue pre-populated with some
19:21 text that inserts metadata uh about what articles being commented
19:27 on so we know where you came from uh when you're typing up your issue so
19:32 you don't have to worry about i saw this problem and linked to and linked to the article it's done that for
19:38 you so the point i want to make with this is so this product means for this
19:44 example it would be a problem with powershell with like the pro the product or the source code
19:51 and this page means the documentation and why they don't just say that
19:57 we all the time have people putting stuff in different in the wrong repo and there's nothing wrong with that hey we appreciate the feedback
20:04 but it just delays it being triaged and getting to the right person to work on and the difference is so in my recode
20:11 uh and i have to check the the document to find out why it wasn't on but it puts you in the right repo because if you say
20:18 if you're on a reference documentation it's going to take you to the source code repo no matter which one you click
20:24 on it's just going to pre-populate so you don't have to hand key all this stuff so getting back to your question
20:31 about how the versions are handled in in the source
20:37 um here's the documentation repo for powershell and
20:44 under the reference folder here is all of the documentation
20:49 and then we have a folder for each version that we currently support and this is where the commandlet reference
20:54 is so if i go in here you'll see there's a folder for each module and then the command lines for that module
21:00 are in each of those folders and this is duplicated for every version
21:07 um so it's almost like a four-man source control that everybody uses where you make a copy of all your stuff right
21:12 exactly what we've done and then under doc's conceptual this is all the stuff that's above the line
21:21 and and it's just marked down now the other thing to that we'll talk about is
21:27 the commandlet reference has a very specific format to it that's sort of
21:32 schematized that our tooling relies on to transform it for the web
21:40 and for updatable help one of the things that jason and i have been working on for the past year that we we got done
21:47 was in powershell docs
21:52 anytime daily when we merge to live it automatically regenerates the updatable help
21:58 so updatable help will have the the new information the edits that we made you just need to run update help dash
22:05 force because the version number doesn't change and that way it forces it to pull it down
22:15 uh where are we mike oh yes let's so hopefully
22:21 everyone's familiar with this process of github just real quick the steps i've
22:28 drawn out here in red are your one-time things you need to fork the microsoft docs repo
22:35 to your account you need to clone your fork down
22:40 to your local machine and create that upstream remote pointer to point back to
22:45 the microsoft docs and then the rest of the step is the normal
22:51 workflow you do for any kind of submission the first thing you want to do is make sure your
22:57 local repo is in sync with the upstream so you pull that down or mikey what do
23:02 you do you do a fetch yeah so what i do i do a fetch and then i do a merge but it's the same thing
23:08 that's doing a hit pool yeah just hey i like to use the predictor
23:16 and once you've synced that up then you can create your working branch
23:22 and edit the files that you want to change
23:29 you add your commits to your branch
23:35 and then you push that working branch up to your fork and then from your fork in github you
23:42 submit a pull request yes a deal just real quick if you are pushing to
23:48 before you make a commitment push if you've been working on something for a while make sure you do that fetch merch before because there may have been
23:55 changes yeah and if you can uh i would recommend rebase
24:00 and don't be scared of rebase on your own local stuff the reason we recommended that
24:07 especially if you're in azure docs in that repo there's thousands of changes a day and i made this mistake i think the
24:13 first couple of days i started microsoft i used that workflow and it made it look like my small change
24:19 that my change can contain everybody else's change since uh since i have refreshed because
24:26 i merged all their stuff in so it was doing the conference book too at the
24:32 same reason yeah so learn rebase it's not that scary
24:37 ultimately what that side does i mean you're always working against your uh fork of the repo
24:43 and then when you when you open up your repo then you submit a full request from yours to the other one and you're
24:50 working off of working or i call it a feature branch but even our contribution
24:55 guides they call it a working range yes how much of that flow is actually
25:03 uh exposed through the web where you click edit
25:11 a good one yeah it does the if you haven't uh
25:17 forked uh it'll create the fork for you and then in the web you're doing edits in your
25:23 fork instead of locally but you can only do one file at a time doing the full workflow
25:30 you could do multiple files to be submitted in a single pr so would you recommend if you have like a quick
25:37 spelling change or a quick context i still recommend this because we're going to show you the problem of versions
25:45 i've never used a simple workflow but it is something in our contribution guides and if you just want if you're you're
25:50 not familiar with get and all that then it's much easier
25:59 okay so now let's get into our whoops yeah our workflow
26:06 so do we want to reverse the rolls since i'm on screen sure
26:13 um to merge yeah so what we have here is we
26:21 have an issue i had it open
26:28 yeah see i was prepared to do that role and so now we're roll reversed so somebody filed an issue for us
26:35 that the wording was confusing for the property type parameter on new item property it made it sound like you could
26:42 use the values regs the reg binary instead of these values of string
26:48 binary expand string and so on and fair feedback
26:54 great idea we need to uh it's simple minor wording change
26:59 so this you know they could have actually contributed this but this one is
27:06 probably a little more advanced so if you do have one advanced feel free to reach out to us but if you found something in our docs and you're like
27:12 hey i want to contribute to that then if you'll follow an issue they'd be appreciated you know
27:17 what do you mean by reach out to us we've got our contact information on that first slide so it's got our email
27:23 address it's students i mean like really reach out to us you know cool with the exception of actually calling
27:29 me enough
27:35 all right so i've got uh vs code up here
27:40 let's see if i can really what we're looking for you know as far as contributions to dots and it's just what i said we're looking for contributors
27:47 you know contributions we're not looking for authors i mean we're the authors we're not expecting you to go on all
27:52 through the continent but if you have something like hey i've got some ideas for this doc it would be awesome and
27:57 it's going to be a major rework and that's a scenario where i would recommend reaching out to this or at least follow an issue to say hey i've
28:03 got this idea and i'd like to do this because we've had some issues that they basically wrote
28:08 the article in their issue you know so it's almost a copy and paste
28:14 uh i'm gonna well i'll do it this way
28:20 all right so i'm gonna go into my reference folder i'll just pick a version uh it's it's in microsoft powershell
28:27 management and we're looking for new item property
28:32 and we want the i'll zoom this up a little bit let's go
28:37 full screen
28:43 and this is a feature i really like with the markdown
28:50 um get used to using the outline because it works in markdown as well so
28:56 we want to go down to the property type and this this helps see the organization
29:02 of what you're writing yeah it's native
29:07 um the one thing you've got to watch out for is make sure you're sorting by position so it appears in the order that
29:13 you've actually written it so it's this content that i want to update
29:21 and i already had the solution in a comment in
29:27 uh the issue i'm just going to paste that in
29:32 and notice i changed the formatting this this is the proper formatting for our style guide we'll show you
29:40 some of that styling but the other thing we do here in our style guide is you notice i have these
29:45 lines these rulers we use this concept of semantic line
29:51 breaks is anybody familiar with semantic line breaks so we don't we're not blanking
29:57 on on phrases or you know semantic concepts as much as
30:04 columns so for us we're using 100 columns and really that makes it easier to read
30:11 easier for the next editor to come in and and see what's going on it helps when you're on a lower
30:16 resolution screen to be able to see it better
30:27 right uh and so here i i want to break up this this long line into multiple lines well
30:34 we have a an extension
30:40 installed here called markdown reflow
30:46 there's a couple of them out there i recommend this one that we have the by marvin and what it is is uh i can
30:54 click here in the anywhere in this paragraph this list item and hit alt q
31:01 and it re-wraps breaking at my 100 column
31:06 limit but it also lines up the indentation properly and doesn't merge in all the
31:13 other list items into one line so it's it's list item where and it's
31:20 uh other uh block aware all this is in our contribution guide
31:26 too as far as the reflow the uh the reflow extension and the line length we use the
31:33 arbitrary line length and all that sort of information
31:39 yeah so there's my 100 column ruler and i have those rulers there just to give
31:44 me a visual cue that oh this line's too long i i need to reflow it the first one
31:53 yeah yeah i have it at 76 80 100 and then i also have these beginning
32:00 on columns one through five so it helps me line up the indentation on the front end for those things that matter
32:09 vs code feature yeah it's uh in your configuration you can set rulers
32:16 here's my configuration file there there it is editor rulers and you
32:21 just specify the column numbers yeah when i started i started microsoft channels on mentor who's gonna call me
32:28 day one at nine o'clock hey are you ready to start you guys should have my bs code
32:33 and he uh he actually got me started on this and i'm like wow this is really slick you know i was gonna ask because the hundred
32:39 woman i guess was off screen when you're zoomed in and i was like they're still going over your lines but do you think that i mean
32:45 so where does that actually make it break oh yeah so the
32:52 the extension itself has settings the reflow markdown
32:58 preferred line length 100.
33:08 if i remember right do you have your contains in your github repo i do so yeah my personal github brief
33:14 yes i do my personal github repo my github alias is
33:20 sd wheeler it's called tools by sean i have a profile folder i have a modules folder
33:26 with my modules in my profile folder you'll see this settings json file so you can
33:31 see how i have it configured let's say sean's got something cool
33:37 he's got everything automated so check out his tools uh okay so how are we doing on time
33:44 all right so i've made the change here and we did this in the five one and i'm
33:51 going to go and i'm going to
34:03 commit my change uh i staged my change and now we're
34:09 going to do update uh
34:15 proper t type description
34:22 that's my commit message i'm going to go ahead and commit that [Music]
34:28 do you have any specific keywords no
34:33 um i just reinstalled this laptop and
34:38 there's something wrong with get in uh visual studio code let me do it this way
34:50 but visual studio code for whatever reason is not picking that up oh and i've customized my prompt here as you can see
34:56 so i've got i'm using poshkit it's telling me the state here i've got the uh
35:03 repo name and the branch name staging is our default branch you always want to be working in staging
35:09 and excuse me you always want to be working in
35:14 um no in a in a working branch and your pr goes to staging though next week
35:22 after conference when i get back we're going to rename staging to maine so
35:29 can on so if you come to my retail or history code with the azure doctory code it will always be maine
35:36 of the main repo but you should be you could create a a feature branch and i think sean's going
35:42 to create one that has the uh the issue yeah 87 39 so
35:47 [Music] publish like behind the scenes
35:52 and we actually i mean if it's a critical thing for something like that we can actually manually push to live as
35:58 well right so this is the pattern i use is
36:03 i create my working branches with my initials it's easier to sort the list and see my branches from somebody else's
36:11 and then i it's it's issue 87 39 that's just my workflow process
36:17 so now i have my changes i'm in a new working branch
36:23 one other thing i wanted to show off about my prompt is i've got this wired up
36:28 you can control click the repo name and it opens
36:36 that is an ansi escape sequence so i'm just embedding
36:42 that in the prompt string all right so i'm going to do a
36:50 git commit dash m
36:55 um update dash property
37:00 type description and then get
37:07 push origin
37:16 and then the nice thing since windows terminal here allows
37:24 you to control click urls i could control click that and it'll open the
37:30 the pr for me but i have a new pr
37:48 it's my own function so part of what my prompt does is every time you hit enter it updates
37:54 this variable called last commit and it puts the commit string of the last commit in that variable
38:01 and then this creates a new pr and auto fills out my pr
38:08 template and it adds the information here so it's
38:14 fixing issue number 8739 so when this gets merged it'll auto close
38:21 the issue so mike's going to do a review on his screen
38:30 so i can see that shawn submitted this dr so i'm gonna go to the files tab and take a look at it
38:40 so i can see the changes and you see they're pretty concise one reason because of the lining
38:47 but i know for a fact so he's updated this in version 5.1 and normally i would go take a look at
38:53 one of the other versions but i already know that the it has the same problem so i'm actually going to review the
38:59 changes and i'm going to say request changes and i'll say you know what fun
39:07 where are the other versions [Laughter]
39:33 and so so this is this is what might happen to you [Laughter]
39:39 we'll make suggestions and we'll use the suggestion feature of you know maybe reword it this way so you can just click
39:45 the commit button and and so on [Laughter]
39:52 um so now what i need to do is go and edit those other versions so i need to open
39:58 up each version the file make the second copy the same changes in and do all that but there's this really cool tool
40:04 there's a software company called scooter software has this
40:09 uh tool called beyond compare and
40:15 how many have used it okay i i swear by this thing i love it and
40:22 if your company won't pay for it it's only like 60 bucks it's worth every penny uh and they don't pay me to say this so
40:30 yeah
40:39 all right so i have another function i've written
40:45 called uh bc sync beyond compare sync or sync beyond compare and i can give it
40:52 a path to the file of one version and
40:57 it knows to compare that to all my other versions
41:02 i can't zoom this unfortunately but this this is the 5.1 version and over
41:09 here i have the 7.0 version so i just need to go down and find my change and you'll see that there's a lot
41:15 of differences here so there's differences between the commandlet versions from 51 to 700 and so on
41:22 we only need to sync the thing that changed that's common to the version
41:29 and that's this right here for property type and you can just click this arrow and it
41:35 copies it over to the other side so i'll save that
41:41 close it and now it's comparing five one to seven one
41:47 so i've done the 7-0 now i need to do the 7-1 boom
41:57 oh there
42:04 copy this change
42:13 and the last one 7.3
42:19 and now i just need to get add
42:25 get commit dash m
42:32 editorial changes to sync
42:39 versions get
42:45 push origin and now
42:51 my pr should be updated and you'll see the build is kicking off
42:56 again so while we're waiting on that one thing i want to tell you so i'm going to give you the answers i'm going to give
43:02 you the cheat sheet you don't take anything out of this and you want to contribute the dots there's a powershell style guide and if
43:08 you scroll through this this is exactly what we look for when we review your pr
43:14 without having to read anything else it tells you all the little details and it's not very long it's not very much to
43:20 read either because we've got 50 000 different contribution guides so if you want to know something about
43:27 an ordered list or anything like that it's all in this one dock
43:33 and that's yeah we're out of time we don't need to show the merger
43:38 um you guys understand that i i do want to show
43:45 whoops more about what's in it for you guys uh contributing out here in the community
43:51 section of our documentation this is where we have our contributors guide that has that checklist but also
43:58 we have this what's new in docs i update this every month
44:05 with links to the new articles or major changes we've made and we list
44:11 community contributors who've submitted prs that we've merged and
44:16 if you do enough you can end up in the contributor hall of fame
44:23 um and so this is for the history of the repo going back to 2015 when it open
44:29 sourced and the folks who have contributed the most pull requests and the most
44:35 github issues and what's that by you hey you can sign it with your social media blog site the
44:40 reason i would use to write for the hay scripting guide in the powershell magazine and all the different ones because i wanted to drive traffic to my
44:46 site because microsoft gets a lot more traffic so that's the reason i write a blog on the community site and i know
44:52 that powershell.org don't take a contribution as well one last thing
45:01 put in a plug for the powershell community blog this is a blog that we have open to the community to do to to submit posts
45:10 uh and the process for doing that is through this github repo and so the editing process is uh all the
45:17 same and and we can help you with that help you with your writing and do that
45:22 editorial review before it gets posted so if you've ever thought about starting a blog
45:27 but you don't want to have to worry about which blogging platform whatever you can get your feet wet here
45:34 yeah so i want to follow andrew's question real quick so if you want to reach out
45:40 to us i mean it's just something generic and just like a github issue but if you have some specific questions about
45:46 something i mean we want to be very involved with the community yep and use our email just send us an email and
45:52 i'm somebody that i like respond to all this stuff you know so uh nothing goes but uh also do we have any questions
46:01 i think we're over our time we are we can take this to the hall thanks for coming
46:06 [Applause]
