//
//  ShinyLayer.swift
//  
//
//  Created by Alex Lee on 4/1/22.
//

import Foundation
#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

/**
 Platform-agnostic wrapper to allow for a common interface for views to add/remove `CALayer`.
 */
struct ShinyLayer {
  var theMask: CALayer

  #if os(iOS)
  weak var owner: UIView?

  init(owner: UIView) {
    self.owner = owner

    theMask = CALayer()
    theMask.anchorPoint = .zero
    theMask.bounds = owner.scintillatingBounds
    theMask.cornerRadius = 8
    theMask.backgroundColor = UIColor(0x1c2325).cgColor
  }
  #endif

  #if os(macOS)
  weak var owner: NSView?

  init(owner: NSView) {
    self.owner = owner

    theMask = CALayer()
    theMask.anchorPoint = .zero
    theMask.bounds = owner.scintillatingBounds
    theMask.cornerRadius = 8
    theMask.backgroundColor = NSColor(0x1c2325).cgColor
  }
  #endif

  func stripFromParent() {
    theMask.removeFromSuperlayer()
  }
}
