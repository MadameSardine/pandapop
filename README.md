# pandapop! [try it live!](http://www.pandapop.co)

## Synopsis

A social karaoke platform built with the YouTube API and Ruby on Rails. Pandapop was created by karaoke lovers, for karaoke lovers, to facilitate a more seamless, natural JPop-style karaoke experience when streaming YouTube videos. Users can search for karaoke videos without interrupting the currently-playing track, queue up their favorite songs, and build themed playlists for future karaoke parties!

MA Demo Night presentation available [here](https://prezi.com/kvo_j01apgct/pandapop/?utm_campaign=share&utm_medium=copy)!

#### Screenshot
![pandapop](https://raw.github.com/MadameSardine/pandapop/master/public/screenshot.png)

## Goals & Purposes

As a group of karaoke enthusiasts, we were excited about building a product that would help other people enjoy the free karaoke media on YouTube, but without the clunky user experience of using YouTube for this purpose. We identified three pain points:

* Search would return results unrelated to karaoke
* Lacks the right 'feel' and visuals
* No easy way to search for and queue up songs spontaneously without interrupting the currently played track

We set out to design a one- or two-page app using client-side Javascript on top of a Rails server. To achieve this, we followed behavior-driven design principles learnt during Makers Academy. BDD and TDD were used extensively to guide the design and implementation of Pandapop.

## Key User Stories

While using Pandapop, a User should be able to...

* Sign up, choose a profile picture, edit her account, and sign out
* Create a custom playlist and add songs only to playlists she owns
* Perform a search on any page of the app without refreshing the page
* Add a song to a playlist from the search results
* Add a song from search results to a queue that persists throughout the app until it is cleared
* Play songs from the queue and skip to the next song
* Star a song from the search results, automatically saving the song to a "Starred Tracks" playlist

## Technologies Used

- Ruby on Rails
- jQuery
- AJAX
- Angular
- PostgresQL
- ActiveRecord
- Git + Heroku
- TDD with Rspec, Poltergeist, Capybara, FactoryGirl
- YouTube API
- Amazon Web Services S3
- HTTParty, Devise, CanCanCan, Figaro

## Collaborators

- Denise Yu (http://www.github.com/deniseyu)
- Nicole Pellicena (http://www.github.com/NicolePell)
- Sandrine Zhang Ferron (http://www.github.com/MadameSardine)
- Sean Stevens (http://www.github.com/slstevens)

## To run:

Make sure you have Ruby and Rails installed first:
```
gem install rails
```

Clone the repo locally and launch the Rails server:
```
git clone git@github.com:MadameSardine/pandapop.git
cd pandapop
bundle install
rails s
```

## To test:

```
git clone git@github.com:MadameSardine/pandapop.git
cd pandapop
rspec
```

## Challenges

We encountered many challenges while developing Pandapop.

#### Choosing the right technology for the task

We chose Rails initially because every team member had familiarity with the framework, and we knew that at a high level, this was a CRUD-reliant application with a need for RESTful internal APIs. On top of that, Rails provides a well-documented, user-friendly testing environment.

However, Rails is also a highly opinionated framework. We spent a lot of time researching the "Rails way" to accomplish tasks that we knew how to do in a lighter framework. We also ran into difficulty while deploying to Heroku, because Heroku could not find some of our assets. It proved to be difficult to debug problems at times due to the sheer weight of Rails and the opacity of some of the gems and libraries we added.

#### Scoping features and tasks

We pair-programmed throughout, and in doing so, tried to split up tasks so that each pair was working on features that were comparable in size. We did not anticipate that it would take two days to properly design the architecture of the playlists and tracks, because we had never tried to post dynamically-loaded parameters (the tracks that are returned by the search results) to a Rails server before.

#### Unexpected interactions among Javascript assets

When we merged all of the features back onto the development branch, we discovered that some of our assets did not want to play together. For example, Angular's 'ng-repeat' adds additional HTML classes to the iterated elements, which created interference with a jQuery 'drag and drop' feature that Sean had built over the weekend.

## Main Takeaways

We learned that while Ruby on Rails is frequently chosen for its ease of use, it is still not an easy task to build with customizability on top of Rails until we have a very solid understanding of what is going on behind the scenes.

We also learned a lot about the process of developing a Minimum Viable Product. A meeting in the beginning of Week 2 with Sam Joseph led us to realize that some of the features we had previously considered to be part of the core functionality were actually not necessary. This was a valuable part of the development process, not only because it saved us from wasting time and energy on non-critical code, but also because it helped us to take a step back and revisit the big picture.

Lastly, we learned about the value of developing a coherent user story and following the story's flow throughout. This process includes having a visual reference for every page of the app. In Week 1, we test-drove all of our code, but by Week 2, we realized that many of our tests broke because we had changed a lot of Views, yet the underlying functionality had not changed. After we wireframed our app in Balsamiq and Gimp, we came to an agreement for every design decision, and we were able to implement those designs using HTML5 and CSS3 rapidly.

## To Do

* Refactor controllers
* Build Angular-powered search for other users
* Debug Angular ng-repeat class issue, restore drag-and-drop
* Improve UX with details such as cursor-pointer CSS tags to indicate clickable objects
* Listen for the end of a song so the next song will play automatically

## Features Wishlist

A User should be able to...

* Follow another User
* Search for other Users
* View his followers and followed lists
* Create an Group
* Add other users to his Groups
* Create a Playlist that a Group can have access to
* Implement a private or public setting on a Playlist

## To Contribute

We are open to pull requests. Fork the repository, clone the repo locally, push up the changes to a new branch and submit a pull request.

If you spot an issue in the code, please feel free to flag it in the issues section.

## Acknowledgements

Team Pandapop would like to thank all of the coaches at Makers Academy for their invaluable help throughout final project week and the entire course. Special thanks goes out to Dana, for introducing September Cohort to Makers Karaoke on Fridays!


