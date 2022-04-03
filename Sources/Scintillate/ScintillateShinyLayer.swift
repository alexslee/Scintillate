//
//  ScintillateShinyLayer.swift
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
struct ScintillateShinyLayer {
  static let animationKey = "jimCarrey"
  var theMask: CALayer

  #if os(iOS)
  weak var owner: UIView?

  init(owner: UIView, settings: ScintillateSettings) {
    self.owner = owner

    theMask = settings.isGradient ? CAGradientLayer() : CALayer()
    theMask.anchorPoint = .zero
    theMask.bounds = owner.scintillatingBounds
    theMask.cornerRadius = 8

    if settings.isGradient {
      let colors = [settings.primaryColor, settings.secondaryColor]
      (theMask as? CAGradientLayer)?.colors = colors.compactMap({ $0?.cgColor })
    } else {
      theMask.backgroundColor = settings.primaryColor.cgColor
    }
  }

  func updateLayout() {
    guard let newBounds = owner?.scintillatingBounds else { return }
    theMask.bounds = newBounds
  }
  #endif

  #if os(macOS)
  weak var owner: NSView?

  init(owner: NSView, settings: ScintillateSettings) {
    self.owner = owner

    theMask = settings.isGradient ? CAGradientLayer() : CALayer()
    theMask.anchorPoint = .zero
    theMask.bounds = owner.scintillatingBounds
    theMask.cornerRadius = 8

    if settings.isGradient {
      let colors = [settings.primaryColor, settings.secondaryColor]
      (theMask as? CAGradientLayer)?.colors = colors.compactMap({ $0?.cgColor })
    } else {
      theMask.backgroundColor = settings.primaryColor.cgColor
    }
  }

  func updateLayout() {
    guard let newBounds = owner?.scintillatingBounds else { return }
    theMask.bounds = newBounds
  }
  #endif

  func stripFromParent() {
    theMask.removeAnimation(forKey: Self.animationKey)
    theMask.removeFromSuperlayer()
  }
}
