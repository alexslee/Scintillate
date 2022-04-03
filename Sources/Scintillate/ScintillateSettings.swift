//
//  File.swift
//  
//
//  Created by Alex Lee on 4/3/22.
//

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

/**
 Defines custom settings you may wish to apply to a given scintillating effect. You may choose to create
 an instance of this for passing into any given call to `kickStart(...)` (see: ``Scintillate``).
 */
@objc public class ScintillateSettings: NSObject {
  /**
   Whether or not the scintillating effect should animate (defaults to false).

   Note: for non-gradient effects, this is a simple transition between the primary color + its complement.
   For gradients, this causes a transition of the gradient horizontally across each given subview.
   */
  public var shouldAnimate = false

  internal var isGradient: Bool { secondaryColor != nil }

  #if canImport(UIKit)
  /// The main color to use for the scintillating effect. For gradients, this is the starting point.
  public var primaryColor: UIColor = .scintillateDefaultShine

  /// A secondary color that, if provided, is treated as the end point for a gradient from the primary color.
  public var secondaryColor: UIColor? = nil

  public init(shouldAnimate: Bool = false,
              primaryColor: UIColor = .scintillateDefaultShine,
              secondaryColor: UIColor? = nil) {
    self.shouldAnimate = shouldAnimate
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }
  #endif

  #if canImport(AppKit)
  /// The main color to use for the scintillating effect. For gradients, this is the starting point.
  public var primaryColor: NSColor = .scintillateDefaultShine

  /// A secondary color that, if provided, is treated as the end point for a gradient from the primary color.
  public var secondaryColor: NSColor? = nil

  public init(shouldAnimate: Bool = false,
              primaryColor: NSColor = .scintillateDefaultShine,
              secondaryColor: NSColor? = nil) {
    self.shouldAnimate = shouldAnimate
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }
  #endif
}
