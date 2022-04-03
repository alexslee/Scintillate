//
//  NSColor+ColorAssets.swift
//
//
//  Created by Alex Lee on 4/2/22.
//
#if canImport(AppKit)
import AppKit

extension NSColor {
  static func color(named name: String) -> NSColor {
    guard let color = NSColor(named: name, bundle: .module) else {
      preconditionFailure("Missing color from asset catalog")
    }

    return color
  }

  public static var scintillateDefaultShine: NSColor { color(named: "defaultShine") }
  public static var scintillateDefaultShineComplement: NSColor { scintillateDefaultShine.defaultComplement }
}
#endif
