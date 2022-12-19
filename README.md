#  LoremPicsumClient

This was something I did for fun, and maybe for my own use. It's a client for browsing [Lorem Picsum's](https://picsum.photos) catalog of pictures. 

 [Lorem Picsum](https://picsum.photos) is a web service that offers up quality images for use in development projects.  It's a very handy tool for web development, and something I honestly wish I had had in my iOS development before. They have a very simple, pretty powerful API that's explained pretty succintly on their main web page.

With LoremIpsumCLient, you can:

• browse the list of pictures available from [Lorem Picsum](https://picsum.photos)
• request and preview specific sizes of those images
• request grayscale or blurred versions of those images
• receive copyable URLs and html examples of using the image with the settings you choose.
• drag the image, with any modifications, to other apps

As I say, it's a very simple app, meant to be a a toy for development.  Still, I could see where some people might find it useful.  If you're interested in how someone does a simple infinite scrolling REST client app using SwiftUI, this might be a good project to look at.

## Architecture:

This app is a SwiftUI app written using MVVM, with heavy use of protocol-driven development and Combine. Every view of any consequence takes a view model of a given protocol. Model objects are extended to support these view model protocols. 

## Model Layer

The API itself is reprresented by a struct called LoremPicsum.  It has several static factory methods which create structs that represent given API calls. These structs vend an URL that represents the composite of all settings within the struct (random or based on id, size, grayscale, etc.). They can return modified versions of themselves via methods.  These structs can then vend their URL, which is passed to a call to URLSession.

There are two different ways that pictures can be retrieved for the master list: as a paged list using infinite scrolling, or as a short list of favorited images.  Each of these approaches is handled by a different List class which each conform to a protocol for listing pictures.  A facade class then wraps instances of each of those classes and vends their responses as appropriate depending on the user's choice.

## View Layer

Views use protocol to define their view model.  Each view interacts with the view model, rather than the model object or whatever that backs it.

## View Model Layer

View Models are implemented by extending the appropriate Model objects to conform to the view model.

## User Interface

The user interface is utilitarian, meant to be used by someone who wants to find an image for their project.  It's not beautiful, but utilitiarian. It's a Master-Detail layout with an infinitely scrolling list in the source list and an inspector on the right side for making changes.  Info is layed out at the bottom of the view.

