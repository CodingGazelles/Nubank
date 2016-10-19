Nubank
======


## Architecture of the Project
### Hypertext Application Language

The project uses its own implementation of Hypertext Application Language standard.

- `protocol NUHALLinkProtocol {}` :  A Link to a Resource
- `protocol NUHTTPResponseProtocol {}` : The HTTP Response returned when calling a Link. Useful for dealing with HTTP Response/Request errors, Json parsing and Resource instantiation.
- `protocol NUHALResourceProtocol {}` : A Resource

The project uses sub-classes of the aforementioned protocols to describe the properties of all links and resources the project will use.

### Patterns Used
#### [Futures](https://en.wikipedia.org/wiki/Futures_and_promises)

Calling the server API in order to get a Resource is done through HTTP requests and responses and therefore is an asynchronous operation. All operations, like printing , depending on an asynchronous operation become in turn asynchronous.

Instead of dealing with asynchronous operations through closures and callback, project uses the concepts of Promises and Futures.

Simply speaking a Future is a 'proxy' object for a result/object that is at the moment
initially unknown, usually because the computation of its value is yet incomplete.

This Pattern facilitates the writing of functional code and data pipelining (See below).


#### Unidirectional Data Flow with [ReSwift](https://github.com/ReSwift/ReSwift)

The project uses ReSwift to implement the [Unidirectional Data Flow](http://redux.js.org/docs/basics/DataFlow.html) pattern. This pattern has been popularized by the [Redux](http://redux.js.org/) framework.

> This means that all data in an application follows the same lifecycle pattern, making the logic of your app more predictable and easier to understand. It also encourages data normalization, so that you don't end up with multiple, independent copies of the same data that are unaware of one another.

4 objects are used to implement this pattern:

- **`class NUStore {}`** : The Store stores your entire app state in the form of a single data structure
- **`  class NUAction: Action {}`** : Actions are objects used to declare a state change.
- **`class NUReducer: Reducer {}`** : Reducers provide pure functions, that based on the current action and the current app state, create a new app state.
- **`struct NUApplicationState: StateType {}`** : The application state is the structure that stores the application state.

#### Forward Pipe Operator & Data Pipelines

  The result of each step becomes the argument of the next step.

  http://pt.slideshare.net/jarsen7/pipes-48485417
  Souligner les liens

  ```swift
  let action = entryPointLink
                  |> callAPI
                  |> getResource
                  |> getUpdateStateAction
  ```


### Framework & Dependencies
The project uses the following dependencies.

- **[antitypical/Result](https://github.com/antitypical/Result)** : Type modelling the success/failure of arbitrary operations
- **[DaveWoodCom/XCGLogger](https://github.com/DaveWoodCom/XCGLogger)** : Logging
- **[ReSwift/ReSwift](https://github.com/ReSwift/ReSwift)** : Unidirectional Data Flow
- **[Thomvis/BrightFutures](https://github.com/Thomvis/BrightFutures)** : Asynchronous code using futures and promises
- **[Alamofire/Alamofire](https://github.com/Alamofire/Alamofire)** : HTTP Networking
- **[IBM-Swift/Pipes](https://github.com/IBM-Swift/Pipes)** : Forward pipe operator

All frameworks are imported through Carthage except :
- **[IBM-Swift/Pipes](https://github.com/IBM-Swift/Pipes)**     =>  Imported directly into the source code of the project. It's a one file framework. ;-)
## Installation

### GitHub
1. Open Terminal
2. Change the current working directory to the location where you want the cloned directory to be made.
3. Execute the following command to [clone](https://help.github.com/articles/cloning-a-repository/) the [Nubank](https://github.com/t4ncr3d3/Nubank) repository on your local drive.
  ```git clone git@github.com:t4ncr3d3/Nubank.git```
### [Carthage](https://github.com/Carthage/Carthage)

1. Install [Carthage](https://github.com/Carthage/Carthage#installing-carthage).

2. Open Terminal and change the current working directory to `Nubank`.

3. Execute the following command to fetch the dependencies and build them.

  ```
  carthage update --platform iOS`
  ```

4. On your application targets’ “General” settings tab, in the “Embedded Binaries” section, drag and drop all the frameworks found inside the [Carthage/Build](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#carthagebuild) folder on disk.
