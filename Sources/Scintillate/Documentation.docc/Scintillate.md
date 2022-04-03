# ``Scintillate``

A UIKit+AppKit-friendly way to either mask content, or show a loading state. Think: SwiftUI's 'redacted'
modifier, for non-SwiftUI applications.

## Usage

### Setup

1. Install the package, which can be done via Swift Package Manager.

2. Decide where you want to invoke the scintillating effect. To start it, you just need to provide the root
view within which you want to apply the effect (remember it's recursive!), and any custom settings you wish.

For instance:

```swift
    Scintillate.kickStart(in: stackView)
```
would start the scintillating effect with default settings (no animation, and a default color).

To turn the effect off, simply call `shutDown` on the same view:
```swift
    Scintillate.shutDown(in: stackView)
```

### Customizing the effect

This can be done via a ``ScintillateSettings`` that you may construct and pass into the `kickStart` method.
It allows you to enable animation (default is off), and customize a color (if you provide a secondary color, it
will be interpreted as a gradient). 

### Detecting Scintillate active status

A static property `isOn` on `Scintillate` informs you whether any scintillating effect is currently active. 
Note: support for multiple scintillate effects being kickstarted + shutdown is not yet in place. It might 
work for multiple `kickStart`s, but a single `shutDown` will set the global `isOn` to false.
