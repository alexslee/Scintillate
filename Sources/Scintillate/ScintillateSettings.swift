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

@objc public class ScintillateSettings: NSObject {
  public var shouldAnimate = false

  internal var isGradient: Bool { secondaryColor != nil }

  #if canImport(UIKit)
  public var primaryColor: UIColor = .scintillateDefaultShine
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
  public var primaryColor: NSColor = .scintillateDefaultShine
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
