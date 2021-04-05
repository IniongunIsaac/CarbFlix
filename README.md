# CarbFlix
An iOS application that displays Batman Movies. The app has the following features:

##### Movies:
A list of Batman movies.

##### Movie Details:
Shows indepth details about a selected movie.

##### Search:
Allows users to search for desired movies.

##### Favorites:
Allows users to add movies to their favorite list and view them at a later time.

## Technology Stack
The app was built using the following:

* RxSwift
* Realm/RxRealm
* Alamofire/RxAlamofire
* MVVM with Repositoy Pattern
* Dependency Injection with Swinject

## 3rd Party Libraries Justification
The app was built using the following third parties:

* `RxSwift`: used for reactive development. It's major advantage over Apple's `Combine` is backward compatibility
* `Alamofire/RxAlamofire`: used for making asynchronous data request in a reactive way. `RxAlamofire` allows for reactive development which provides an edge over using `URLSession` since the project is configured using Rx.
    PS: Reactive Wrappers can be written around `URLSession` but why reinvent the wheel when you can just tap into the widely accepted RxAlamofire?
* `Kingfisher`: Provides a convenient way to load images into `UIImageView`. It allows provides image caching functionalities out of the box.
* `R.swift`: Provide a really great way to access project-wide static assets. This has huge advantages over using string literals. I mean, I could write a book about the dangers of `String` Literals.
* `RealmSwift/RxRealm`: Besides the fact the `Realm` provides an arguably better API for interacting with mobile databases, offline data can be synced to the cloud in a Firebase-esque way which is something Apple's `CoreData` SDK doesn't have. Oh, and I can tap into it's already implemented `Rx` functionalities. Again, no need to reinvent the wheel.
* `Swinject/SwinjectStoryboard`: A very lightweight library that allows for easy Dependency Injection. The need for proper management of dependencies within a project cannot be overemphasized and `Swinject` provides just the perfect setup for that. So why write dependencies by hand when you can just have a setup that manages everything for you without hassles?


### How to run(installation):

* Clone this repository.
* Cd into the root directory.
* Open `xcworkspace` project using Xcode (PS: No need to run `pod install` because all pods used have been checked into the version control system).
* Build and run the project on the XCode Simulator or any physically connected iOS device.

### Screenshots
<img src="https://github.com/IniongunIsaac/CarbFlix/blob/main/CarbFlix/Screenshots/movies.png" width="400" height="750" alt="Movies">     <img src="https://github.com/IniongunIsaac/CarbFlix/blob/main/CarbFlix/Screenshots/movie_details.png" width="400" height="750" alt="Movie Details">

<img src="https://github.com/IniongunIsaac/CarbFlix/blob/main/CarbFlix/Screenshots/empty_search_state.png" width="400" height="750" alt="Empty Search State">     <img src="https://github.com/IniongunIsaac/CarbFlix/blob/main/CarbFlix/Screenshots/search_results.png" width="400" height="750" alt="Search Results">

<img src="https://github.com/IniongunIsaac/CarbFlix/blob/main/CarbFlix/Screenshots/favorites.png" width="400" height="750" alt="Favorites">

