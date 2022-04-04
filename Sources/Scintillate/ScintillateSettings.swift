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

   Note: for non-gradient effects, this is a simple transition between the primary color + either the secondary
   color you provide, or the primary's complement (Scintillate will attempt to obtain a default complement value by
   taking the `CIColor` of your primary color, and calculating its inverse).
   For gradients, this causes a transition of the gradient horizontally across each given subview.
   */
  public var shouldAnimate = false

  /**
   Whether or not the scintillating effect should be shown as a gradient (defaults to false).

   Note: to customize the end value of your gradient, provide a non-nil `secondaryColor`. Otherwise, Scintillate
   will attempt to obtain a default complement value by taking the `CIColor` of your primary color, and calculating
   its inverse.
   */
  public var shouldUseGradient = false

  #if canImport(UIKit)
  /// The main color to use for the scintillating effect. For gradients, this is the starting point.
  public var primaryColor: UIColor = .scintillateDefaultShine

  /**
   A secondary color that, if provided, is treated as the end point for a gradient from the primary color, and
   the second color to animate between for non-gradient animated effects. In its absence, Scintillate will
   attempt to obtain a default complement value by taking the `CIColor` of your primary color, and calculating
   its inverse.
   */
  public var secondaryColor: UIColor? = nil

  public init(shouldAnimate: Bool = false,
              shouldUseGradient: Bool = false,
              primaryColor: UIColor = .scintillateDefaultShine,
              secondaryColor: UIColor? = nil) {
    self.shouldAnimate = shouldAnimate
    self.shouldUseGradient = shouldUseGradient
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }
  #endif

  #if canImport(AppKit)
  /// The main color to use for the scintillating effect. For gradients, this is the starting point.
  public var primaryColor: NSColor = .scintillateDefaultShine

  /**
   A secondary color that, if provided, is treated as the end point for a gradient from the primary color, and
   the second color to animate between for non-gradient animated effects. In its absence, Scintillate will
   attempt to obtain a default complement value by taking the `CIColor` of your primary color, and calculating
   its inverse.
   */
  public var secondaryColor: NSColor? = nil

  public init(shouldAnimate: Bool = false,
              shouldUseGradient: Bool = false,
              primaryColor: NSColor = .scintillateDefaultShine,
              secondaryColor: NSColor? = nil) {
    self.shouldAnimate = shouldAnimate
    self.shouldUseGradient = shouldUseGradient
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }
  #endif
}
