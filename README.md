# Scintillate

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

## Internal implementation

You can look through the code, but tl;dr, the effect is recursively applied as a ``CALayer`` per view (with optional
use of ``CAGradientLayer`` and ``CAAnimation`` depending on your settings). These layers should be removed
automatically for you when the effect is shut down.

## TODOs:

- [x] Check tablet appearance + fix rotation behaviour
- [x] Make color customizable
- [x] Actually make them shiny (read: animate the layers)
- [ ] All the bugfixes
