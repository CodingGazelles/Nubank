Nubank
======


## Architecture of the Project

### Hypertext Application Language

The project uses 2 objects to modelize the links and the resources.

```swift
protocol NUResourceProtocol {}
protocol NULinkProtocol {}

```

Sub-protocols are used to describe the functional requirements of each link and resource. All links and resources are described this way.

Protocol ```NUEntryPointLinkProtocol``` describes a link that points to the  ```NUEntryPointResourceProtocol``` resource.

```swift
protocol NUEntryPointLinkProtocol: NULinkProtocol {
    func getResource() -> NUEntryPointResourceProtocol
}

protocol NUEntryPointResourceProtocol: NUResourceProtocol {
    var noticeLink: NUNoticeLinkProtocol? { get }
}
```

### Protocols and Implementations

All the model objects are first defined with protocols. The implementation details are coded in separate files.

### Patterns Used
#### Futures



#### Function Chaining

Each method returns an object, allowing the calls to be chained together.

```swift
Put an example here !!!
```

#### Unidirectional Data Flow with [ReSwift](https://github.com/ReSwift/ReSwift)

The project uses ReSwift to implement the [Unidirectional Data Flow](http://redux.js.org/docs/basics/DataFlow.html) pattern. This pattern has been popularized by the [Redux](http://redux.js.org/) framework.

> This means that all data in an application follows the same lifecycle pattern, making the logic of your app more predictable and easier to understand. It also encourages data normalization, so that you don't end up with multiple, independent copies of the same data that are unaware of one another.

4 objects are used to implement this pattern:

- The Store stores your entire app state in the form of a single data structure

  ```
  class NUStore {}
  ```

- Actions are objects used to declare a state change.

  ```  
  class NUAction: Action {}
  ```

- Reducers provide pure functions, that based on the current action and the current app state, create a new app state

  ```
  class NUReducer: Reducer {}
  ```

- The application state is the structure that stores the application state.

  ```
  struct NUApplicationState: StateType {}
  ```



## Installation

### GitHub

1. Open Terminal

2. Change the current working directory to the location where you want the cloned directory to be made.

3. Execute the following command to [clone](https://help.github.com/articles/cloning-a-repository/) the [Nubank](https://github.com/t4ncr3d3/Nubank) repository on your local drive.

  ```
  git clone git@github.com:t4ncr3d3/Nubank.git
  ```


### [Carthage](https://github.com/Carthage/Carthage)

1. Install [Carthage](https://github.com/Carthage/Carthage#installing-carthage).

2. Open Terminal and change the current working directory to `Nubank`.

3. Execute the following command to fetch the dependencies and build them.

  ```
  carthage update --platform iOS`
  ```

4. On your application targets’ “General” settings tab, in the “Embedded Binaries” section, drag and drop all the frameworks found inside the [Carthage/Build](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#carthagebuild) folder on disk.
