//
//  NSView+JankyVars.swift
//  
//
//  Created by Alex Lee on 4/2/22.
//

#if canImport(AppKit)
import AppKit
import Foundation

extension NSView {
  private struct Constants {
    static var currentShinyLayer = "currentShinyLayer"
  }

  var currentShinyLayer: ShinyLayer? {
    get {
      objc_getAssociatedObject(self, &Constants.currentShinyLayer) as? ShinyLayer
    }
    set {
      objc_setAssociatedObject(self, &Constants.currentShinyLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
#endif
