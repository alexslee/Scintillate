//
//  UIView+ScintillateSwizzlerKebab.swift
//  
//
//  Created by Alex Lee on 4/2/22.
//

#if canImport(UIKit)
import Foundation
import UIKit

extension UIView: ScintillateSwizzlerKebab {
  @objc private func scintillateLayoutSubviews() {
    scintillateLayoutSubviews()
    guard currentShinyLayer != nil else { return }
    Scintillate.parse(self, apply: {
      guard let current = $0 as? UIView else { return }
      current.currentShinyLayer?.updateLayout()
    })
  }

  @objc private func scintillateTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    scintillateTraitCollectionDidChange(previousTraitCollection)
    Scintillate.parse(self, apply: {
      guard let current = $0 as? UIView,
        let settings = current.currentSettings else {
          return
      }

      current.dull()
      current.theShining(with: settings)
    })
  }

  func swizzle() {
    guard let targetLayout = class_getInstanceMethod(UIView.self, #selector(Self.layoutSubviews)),
      let newLayout = class_getInstanceMethod(UIView.self, #selector(scintillateLayoutSubviews)) else {
        return
    }

    method_exchangeImplementations(targetLayout, newLayout)

    guard let targetTrait = class_getInstanceMethod(UIView.self, #selector(Self.traitCollectionDidChange(_:))),
      let newTrait = class_getInstanceMethod(UIView.self, #selector(scintillateTraitCollectionDidChange(_:))) else {
        return
    }

    method_exchangeImplementations(targetTrait, newTrait)
  }

  func deswizzle() {
    guard let originalLayout = class_getInstanceMethod(UIView.self, #selector(Self.layoutSubviews)),
      let scintillateLayout = class_getInstanceMethod(UIView.self, #selector(scintillateLayoutSubviews)) else {
        return
    }

    method_exchangeImplementations(scintillateLayout, originalLayout)

    guard let originalTrait = class_getInstanceMethod(UIView.self, #selector(Self.traitCollectionDidChange(_:))),
      let scintillateTrait = class_getInstanceMethod(UIView.self, #selector(scintillateTraitCollectionDidChange(_:))) else {
        return
    }

    method_exchangeImplementations(scintillateTrait, originalTrait)
  }
}
#endif
