//
//  NSView+ScintillateSwizzlerKebab.swift
//  
//
//  Created by Alex Lee on 4/2/22.
//

#if canImport(AppKit)
import Foundation
import AppKit

extension NSView: ScintillateSwizzlerKebab {
  @objc private func scintillateLayout() {
    Scintillate.parse(self, apply: {
      guard let current = $0 as? NSView else { return }
      current.currentShinyLayer?.updateLayout()
    })
  }

  func swizzle() {
    guard let targetMethod = class_getInstanceMethod(NSView.self, #selector(Self.layout)),
      let newMethod = class_getInstanceMethod(NSView.self, #selector(scintillateLayout)) else {
        return
    }

    method_exchangeImplementations(targetMethod, newMethod)
  }

  func deswizzle() {
    guard let originalMethod = class_getInstanceMethod(NSView.self, #selector(Self.layout)),
      let scintillateMethod = class_getInstanceMethod(NSView.self, #selector(scintillateLayout)) else {
        return
    }

    method_exchangeImplementations(scintillateMethod, originalMethod)
  }
}
#endif
