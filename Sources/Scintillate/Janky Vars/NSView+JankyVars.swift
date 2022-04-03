//
//  NSView+JankyVars.swift
//  
//
//  Created by Alex Lee on 4/2/22.
//

#if canImport(AppKit)
import AppKit
import Foundation

internal extension NSView {
  private struct Constants {
    static var currentShinyLayer = "currentShinyLayer"
  }

  var currentShinyLayer: ScintillateShinyLayer? {
    get {
      objc_getAssociatedObject(self, &Constants.currentShinyLayer) as? ScintillateShinyLayer
    }
    set {
      objc_setAssociatedObject(self, &Constants.currentShinyLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
#endif
