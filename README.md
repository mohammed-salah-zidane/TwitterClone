# Twitter Client iOS App

TwitterClient  app represents a real world client app twitter example: it provides a fairly complex set of functionalities, it's a suitable showcase for all the advantages that architecture components bring, has all features that would make it a modular, scalable, testable and maintainable app.

# Implemented Using

* MVVM with RxSwift
* RxMoya for Netwokring
* Coordinators (Navigators) pattern for app flow
* Modular Archicture (App, Data, Core, Presentation)
* Many Design patterns (Builder, Repository, Singletone, Strategy... etc )
* Storyboards, Nib files and programmatically for design the views
* Realm Database
* OAuthSwift
* Twitter API
* Self Imlemented reusable componants(Pager Table View with refresher, Image Zoom Preview,...etc ) 
 
# Review Demo Video
 [![Video Demo](https://github.com/mohammed-salah-zidane/TwitterClone/blob/main/blob/twitterClient.jpeg)](https://www.youtube.com/watch?v=WLxbBARMAbQ)
 
# App Features

* Login with Twitter
* Add and switch betweeen multiple twitter accounts
* Load user follwers with pagination
* Offline Caching for the followers

# Usage

Pull or download the repo after that make  'pod install' command then you can run and build on a real device because some static freamworks added for real devices.

# Note
The Twitter API key have a limited requests so it may stop to return user followers, if this happened you have to change twitter api credentials.


# Modular Architecture

  <img src="https://github.com/mohammed-salah-zidane/TwitterClone/blob/main/blob/modular-arch-diagram.png" height="600">
 
 ### 🛡 License
<details>
    <summary>
        Click to reveal License
    </summary>
    
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
