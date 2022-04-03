# Scintillate

A lightweight, UIKit+AppKit-friendly way to either mask content, or show a loading state. Think: SwiftUI's 'redacted'
modifier, for non-SwiftUI applications on iOS + macOS.

## Internal implementation

You can look through the code, but tl;dr, the effect is recursively applied as a ``CALayer`` per subview* (with optional
use of ``CAGradientLayer`` and ``CAAnimation`` depending on your settings). These layers should be removed
automatically for you when the effect is shut down.
 
(* _Note: 'per subview' here refers to the absolute bottoms of the view hierarchy. I.e., thinking of it as a tree data structure, 
the effect will only be applied to leaves._)

### Also...

I don't have much in the way of AppKit experience, so it may not function as smoothly with `NSView`s as it does for `UIView`s. 
Let me know if anything pops up there.

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

## TODOs:

- [x] Check tablet appearance + fix rotation behaviour
- [x] Make color customizable
- [x] Actually make them shiny (read: animate the layers)
- [ ] Add more options for customization (maybe)
- [ ] Refine animation speed (and maybe make customizable ^)
- [ ] All the bugfixes
