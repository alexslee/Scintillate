//
//  NSView+Scintillatable.swift
//  
//
//  Created by Alex Lee on 4/1/22.
//

#if canImport(AppKit)
import AppKit

// MARK: - Scintillatable

extension NSView: Scintillatable {
  public var subScintillables: [Scintillatable] { subviews as [Scintillatable] }

  public var isOnScreen: Bool {
    if isHidden || alphaValue == 0 || frame.equalTo(.zero) || frame.equalTo(window?.frame ?? NSScreen.main?.frame ?? .zero) {
      return false
    }

    if String(describing: classForCoder).hasPrefix("_") { return false }

    // TODO: what even are some macOS views to avoid...
//    var superviewRef = superview
//
//    let ignoredClassNames = [
//      "UINavigationButton",
//      "_UIPageViewControllerContentView",
//      "UITableViewCellContentView"]
//
//    if ignoredClassNames.contains(where: { $0 == String(describing: classForCoder) }) { return false }
//
//    while superviewRef != nil {
//      // early return if you discover the view is of an ignored type
//      for ignoredClassName in ignoredClassNames {
//        if let ignoredClass = NSClassFromString(ignoredClassName) {
//          if superviewRef?.isMember(of: ignoredClass) ?? false { return false }
//        }
//      }
//
//      // otherwise, continue going up the view hierarchy
//      superviewRef = superviewRef?.superview
//    }

    return true
  }

  public func theShining(with settings: ScintillateSettings) {
    let newShinyLayer = ScintillateShinyLayer(owner: self, settings: settings)
    currentShinyLayer = newShinyLayer
    layer?.insertSublayer(newShinyLayer.theMask, at: .max)

    if settings.shouldAnimate {
      anime(settings: settings)
    }
  }

  public func dull() {
    guard let currentLayer = currentShinyLayer else { return }
    currentLayer.stripFromParent()
    currentShinyLayer = nil
  }
}

// MARK: - Helpers

internal extension NSView {
  var scintillatingBounds: CGRect {
    if let parentStackView = (superview as? NSStackView) {
      var origin: CGPoint = .zero
      switch parentStackView.alignment {
      case .trailing:
        origin.x = scintillatingWidth
      default:
        break
      }
      return CGRect(origin: origin, size: scintillatingSize)
    }
    return CGRect(origin: .zero, size: scintillatingSize)
  }

  var scintillatingSize: CGSize {
    let heightFromConstraints = verticalConstraints.compactMap({ $0.constant }).max() ?? 0
    let height = max(frame.size.height, heightFromConstraints)

    return CGSize(width: scintillatingWidth, height: height)
  }

  var scintillatingWidth: CGFloat {
    let widthFromConstraints = horizontalConstraints.compactMap({ $0.constant }).max() ?? 0
    return max(frame.size.width, widthFromConstraints)
  }

  var verticalConstraints: [NSLayoutConstraint] {
    constraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.height }
  }

  var horizontalConstraints: [NSLayoutConstraint] {
    constraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.width }
  }

  private func anime(settings: ScintillateSettings) {
    var theAnimation: CAAnimation

    if settings.shouldUseGradient {
      let startAnimation = CABasicAnimation(keyPath: "startPoint")
      startAnimation.fromValue = CGPoint(x: -1, y: 0.5)
      startAnimation.toValue = CGPoint(x: 1, y: 0.5)
      let endAnimation = CABasicAnimation(keyPath: "endPoint")
      endAnimation.fromValue = CGPoint(x: 0, y: 0.5)
      endAnimation.toValue = CGPoint(x: 2, y: 0.5)

      let group = CAAnimationGroup()
      group.animations = [startAnimation, endAnimation]
      group.duration = ScintillateShinyLayer.animationDuration
      group.repeatCount = HUGE
      group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

      theAnimation = group
    } else {
      let animation = CABasicAnimation(keyPath: "backgroundColor")
      animation.fromValue = settings.primaryColor
      animation.toValue = settings.secondaryColor?.cgColor ?? settings.primaryColor.defaultComplement.cgColor

      animation.autoreverses = true
      animation.duration = ScintillateShinyLayer.animationDuration
      animation.repeatCount = HUGE
      animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

      theAnimation = animation
    }

    CATransaction.begin()
    currentShinyLayer?.theMask.add(theAnimation, forKey: ScintillateShinyLayer.animationKey)
    CATransaction.commit()
  }
}

extension NSColor {
  var defaultComplement: NSColor {
    guard let ciColor = CIColor(color: self) else { return self }

    let complementR = 1 - ciColor.red
    let complementG = 1 - ciColor.green
    let complementB = 1 - ciColor.blue

    return NSColor(red: complementR,
                   green: complementG,
                   blue: complementB,
                   alpha: 1)
  }
}
#endif
