//
//  UIColor+ColorAssets.swift
//  
//
//  Created by Alex Lee on 4/2/22.
//
#if canImport(UIKit)
import UIKit

extension UIColor {
  static func color(named name: String) -> UIColor {
    guard let color = UIColor(named: name, in: .module, compatibleWith: nil) else {
      preconditionFailure("Missing color from asset catalog")
    }

    return color
  }

  static var defaultShine: UIColor { color(named: "defaultShine") }
}
#endif
