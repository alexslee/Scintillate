//
//  Scintillatable.swift
//
//
//  Created by Alex Lee on 4/1/22.
//

import Foundation

/**
 _(Not a real word, but hey that's why we're developers and not authors...)_ Platform-agnostic wrapper
 around views that (hopefully) allows ``Scintillate`` to cover any view.
 */
@objc public protocol Scintillatable {
  /**
     Defines list of child objects to which the ``Scintillate`` tool can apply the effect. E.g. for views,
     this would typically be its subviews.
     */
  var subScintillables: [Scintillatable] { get }

  /// Whether the object is visible on screen.
  var isOnScreen: Bool { get }

  /// Remove the current ``ScintillateShinyLayer``, if one exists.
  func dull()

  /// Apply a new ``ScintillateShinyLayer``.
  func theShining(with settings: ScintillateSettings)
}
