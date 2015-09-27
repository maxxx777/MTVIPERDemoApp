VIPERDemoApp
====================

This demo app presents an architectural approach which was applied for one real life project. 

TL;DR
====================
There was a task to create app with well-defined parts and connections between them. Those parts either has similar business logic or reuse the same logic. There is not only one app, but some apps, parts of which are repeated by 90 percent. Furthermore, there is a task to separate off View Layer, Business Logic and Data/Network Layer in order to make changes and fix bugs in a piece of code without the influence of other pieces.
Looking for architectural approach there is chosen [VIPER](https://www.objc.io/issues/13-architecture/viper/). Among [many ideas](http://khanlou.com/2014/03/model-view-whatever/) this approach suits for that app architecture better than any other.

I can not share production code, so I create this demo app. This demo app contains only two modules, because it is just demo.

Overview
====================

Horizontal architecture of the app consists of modules. Each screen of the app is a distinct module. It gives flexibility of modules' connection and ability to replace modules.

`AppModuleConnector` class configures dependencies in `didFinishLaunchingWithOptions` method of `AppDelegate`. Then `AppModuleConnector` performs first navigation. Module stack is being created when navigating. Initialization, configuration and navigation of a stack happen inside of a child of `MTRootWireframe` class.

Vertical architecture of a stack is presented on the picture:

![ScreenShot](https://cloud.githubusercontent.com/assets/2142832/9882759/23f43bf8-5bf8-11e5-9723-58b91838c2ad.png)

**View** drawing can be done either programmatically or in storyboards/XIBs.<br />
**ViewController** does only common UIKit things, so it can be reused for several modules.<br />
**Presenter** does all module-specific things (stings, flags, event handling).<br />
In this demo app I used `UITableViewController` inside `UIViewController` with distinct presenters for both of them, so I separated `UITableView` logic from `UINavigationBar` and `UIToolBar` logic.<br />
**Presenter** connected with one or several **Interactors**. **Interactor** is a unit of business-logic. For example, Data Request, Data Fetch, Email/Password Sign In, Facebook Sign In, Location Detect are units of business-logic.<br />
**Interactors** connected with **presenters** asynchronously and with **DataManager**/**NetworkWrapper** via blocks.<br />
**DataManager** does operations with data, for example select data source (server/local database), merge and cache data.

Conclusion
====================

I would apply this approach only for large long-life projects, especially if this has well-defined modules and several versions (like Full and Lite).

**Pros:**
- separation into modules and layers casts light upon responsibility of each piece of code and enables to find and fix bugs more quickly, to test each piece of code and interaction between them, to use and replace libs and frameworks easy, to avoid Massive View Controller.

**Cons:**
- so much time to implement each module, layer, connection. Refactoring of existing project can take to several months.
- project becomes too bulky. In my opinion, using this architecture for small projects will be overengineering. This demo app consists of only two modules. Using this architecture for app with two screen probably not worth it. 

**PS**

I presented my point of view on VIPER in this demo app. I will be glad if it will be useful for somebody.
Thanks in advance for any advice and remarks.

Further Reading:
====================

- http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/
- https://www.objc.io/issues/13-architecture/viper/
- https://medium.com/brigade-engineering/brigades-experience-using-an-mvc-alternative-36ef1601a41f
- https://speakerdeck.com/sergigracia/clean-architecture-viper
 
Usage
====================
Clone the pepository with all submodules (see submodules in `Utilities/External`)
