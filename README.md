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
MIT License

Copyright (c) 2021 Mohamed Salah Zidane

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
