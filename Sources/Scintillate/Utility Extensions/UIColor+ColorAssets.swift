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

  /// The default color applied to the scintillating effect.
  public static var scintillateDefaultShine: UIColor { color(named: "defaultShine") }
  /// The complement of the default color applied to the scintillating effect.
  public static var scintillateDefaultShineComplement: UIColor { color(named: "defaultShineHighlight") }
}
#endif
