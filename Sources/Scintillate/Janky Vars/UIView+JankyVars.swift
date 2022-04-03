//
//  UIView+JankyVars.swift
//  
//
//  Created by Alex Lee on 4/2/22.
//

#if canImport(UIKit)
import Foundation
import UIKit

internal extension UIView {
  private struct Constants {
    static var currentShinyLayer = "currentShinyLayer"
    static var currentSettings = "currentSettings"
  }

  var currentShinyLayer: ScintillateShinyLayer? {
    get {
      objc_getAssociatedObject(self, &Constants.currentShinyLayer) as? ScintillateShinyLayer
    }
    set {
      objc_setAssociatedObject(self, &Constants.currentShinyLayer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  var currentSettings: ScintillateSettings? {
    get {
      objc_getAssociatedObject(self, &Constants.currentSettings) as? ScintillateSettings
    }
    set {
      objc_setAssociatedObject(self, &Constants.currentSettings, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
#endif
