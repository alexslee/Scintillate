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
