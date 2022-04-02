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
    Scintillate.parse(self, apply: {
      guard let current = $0 as? UIView else { return }
      current.currentShinyLayer?.updateLayout()
    })
  }

  func swizzle() {
    guard let targetMethod = class_getInstanceMethod(UIView.self, #selector(Self.layoutSubviews)),
      let newMethod = class_getInstanceMethod(UIView.self, #selector(scintillateLayoutSubviews)) else {
        return
    }

    method_exchangeImplementations(targetMethod, newMethod)
  }

  func deswizzle() {
    guard let originalMethod = class_getInstanceMethod(UIView.self, #selector(Self.layoutSubviews)),
      let scintillateMethod = class_getInstanceMethod(UIView.self, #selector(scintillateLayoutSubviews)) else {
        return
    }

    method_exchangeImplementations(scintillateMethod, originalMethod)
  }
}
#endif
