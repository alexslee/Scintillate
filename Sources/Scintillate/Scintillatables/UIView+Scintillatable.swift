//
//  UIView+Scintillatable.swift
//  
//
//  Created by Alex Lee on 4/1/22.
//
#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit

extension UIStackView {
  public override var subScintillables: [Scintillatable] { arrangedSubviews as [Scintillatable] }
}

extension UICollectionViewCell {
  public override var subScintillables: [Scintillatable] { contentView.subviews as [Scintillatable] }
}

// MARK: - Scintillatable

extension UIView: Scintillatable {
  @objc public var subScintillables: [Scintillatable] { subviews as [Scintillatable] }

  public var isOnScreen: Bool {
    if isHidden || alpha == 0 || frame.equalTo(.zero) || frame.equalTo(window?.bounds ?? UIScreen.main.bounds) {
      return false
    }

    if String(describing: classForCoder).hasPrefix("_") { return false }

    var superviewRef = superview

    let ignoredClassNames = [
      "UINavigationButton",
      "_UIPageViewControllerContentView",
      "UITableViewCellContentView"]

    if ignoredClassNames.contains(where: { $0 == String(describing: classForCoder) }) { return false }

    while superviewRef != nil {
      // early return if you discover the view is of an ignored type
      for ignoredClassName in ignoredClassNames {
        if let ignoredClass = NSClassFromString(ignoredClassName) {
          if superviewRef?.isMember(of: ignoredClass) ?? false { return false }
        }
      }

      // otherwise, continue going up the view hierarchy
      superviewRef = superviewRef?.superview
    }

    return true
  }

  public func theShining() {
    let newShinyLayer = ShinyLayer(owner: self)
    currentShinyLayer = newShinyLayer

    layer.insertSublayer(newShinyLayer.theMask, at: .max)
  }

  public func dull() {
    guard let currentLayer = currentShinyLayer else { return }
    currentLayer.stripFromParent()
    currentShinyLayer = nil
  }
}

extension UIView {
  var scintillatingBounds: CGRect {
    if let stackView = superview as? UIStackView {
      var origin: CGPoint = .zero
      origin.x = (stackView.alignment == .trailing) ? scintillatingWidth : 0
      return CGRect(origin: origin, size: scintillatingSize)
    }
    return CGRect(origin: .zero, size: scintillatingSize)
  }

  private var scintillatingSize: CGSize {
    let heightFromConstraints = heightConstraints.compactMap({ $0.constant }).max() ?? 0
    let height = max(frame.size.height, heightFromConstraints)
    return CGSize(width: scintillatingWidth, height: height)
  }

  var scintillatingWidth: CGFloat {
    let widthFromConstraints = widthConstraints.compactMap({ $0.constant }).max() ?? 0
    return max(frame.size.width, widthFromConstraints)
  }

  var heightConstraints: [NSLayoutConstraint] {
    constraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.height }
  }

  var widthConstraints: [NSLayoutConstraint] {
    constraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.width }
  }
}

extension UIColor {
  convenience init(_ hex: UInt) {
    self.init(
      red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(hex & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
#endif
