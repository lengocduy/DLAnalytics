# DLAnalytics

![CI](https://github.com/lengocduy/DLAnalytics/workflows/CI/badge.svg)
[![Version](https://img.shields.io/cocoapods/v/DLAnalytics.svg?style=flat)](http://cocoapods.org/pods/DLAnalytics)
[![License](https://img.shields.io/cocoapods/l/DLAnalytics.svg?style=flat)](http://cocoapods.org/pods/DLAnalytics)
[![Platform](https://img.shields.io/cocoapods/p/DLAnalytics.svg?style=flat)](http://cocoapods.org/pods/DLAnalytics)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

An abstract Analytics Framework supports:

- Unify Analytics.
- Modularize, Centralize Analytics.
- Plugin the new Analytics easier.
- Standadize tracking method and event.

## Requirements

- Xcode 12+
- Swift 5.0+

## How

### Setup

1. Implement your AnalyticsService.

```
class ClientAnalyticsImpl: AnalyticsService {
    func setUserIdentifyProperty(_ property: [String : String]) {
		print("setUserIdentifyProperty: To support identify the user")
	}
	
	func reset() {
		print("reset: To reset all data related to the user e.g user logout")
	}
	
	func send(event: AnalyticsEvent) {
        // Here is the specific Analytics implementation e.g FireBaseAnalytics, MixPanel, etc.
		print("### Send an event name: \(event.name), payload = \(event.payload)")
	}
}
```

2. Declare your custom event.

```
// MARK: - Support dynamic configurable payload for an event
struct InputOTPEvent: AnalyticsEvent {
    private(set) var payload: [String: String]
    
    var name: String {
        return "InputOTP"
    }

    static func inputOTPSuccess() -> InputOTPEvent {
        return InputOTPEvent(payload: ["OTPValid": "1"])
    }
}

// MARK: - Enum support static configurable payload for an event
@frozen
enum CheckoutEvent: String, AnalyticsEvent {
	case success = "Checkout_Success"
	case error = "Checkout_Error"

	internal var payload: [String: Any] {
		return [:]
	}
	
	var name: String {
		return rawValue
	}
}
```

3. Register your custom AnalyticsService.

```
let analyticsService = ClientAnalyticsImpl()
Analytics.registerAnalyticsService(analyticsService)
```

### Use

```
/// Simulate tracking event InputOTP success
Analytics.send(event: InputOTPEvent.inputOTPSuccess())
Analytics.send(event: CheckoutEvent.success)

/// Output:
Send an event name: InputOTP, payload = ["OTPValid": "1"]
Send an event name: Checkout_Success, payload = [:]
```

## Installation

There are three ways to install `DLAnalytics`

### CocoaPods

Just add to your project's `Podfile`:

```
pod 'DLAnalytics', '~> 1.1'
```

### Carthage

Add following to `Cartfile`:

```
github "lengocduy/DLAnalytics" ~> 1.1
```

- To building platform-independent xcframeworks Xcode 12 and above [here](https://github.com/Carthage/Carthage#building-platform-independent-xcframeworks-xcode-12-and-above)
- To migrating from framework bundles to xcframework [here](https://github.com/Carthage/Carthage#migrating-a-project-from-framework-bundles-to-xcframeworks)

### Swift Package Manager

Create a `Package.swift` file:

```
// swift-tools-version:5.0

import PackageDescription

let package = Package(
        name: "TestDLAnalytics",

        dependencies: [
            .package(url: "https://github.com/lengocduy/DLAnalytics.git", from: "1.1.0"),
        ],

        targets: [
            .target(
                    name: "TestDLAnalytics",
                    dependencies: ["DLAnalytics"])
        ]
)

```

## Architecture

![Architecture](ArchDiagram.png)

## Interaction Flow

![Interaction Flow](InteractionFlow.png)

## License

DLAnalytics is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
