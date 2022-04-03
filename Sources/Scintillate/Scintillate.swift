//
//  Scintillate.swift
//
//
//  Created by Alex Lee on 4/1/22.
//

import Foundation
import os.log

public struct Scintillate {
  /// Externally available indicator of whether the scintillating effect is currently active.
  public static var isOn: Bool { reallyOn }

  /// Internal tracker of whether the scintillating effect is currently active.
  private static var reallyOn = false

  /// Set this to true to view debug logs.
  internal static var showLogs = false

  /**
   Adds the scintillating effect to the subviews of the provided view.

   - Parameters:
     - view: the root view whose subviews are recursively parsed out, for the purpose of applying the
       scintillating effect.
     - settings: Any custom settings you wish to apply to this given scintillate effect. See ``ScintillateSettings``
       for more info.
   */
  public static func kickStart(in view: Scintillatable,
                               with settings: ScintillateSettings = ScintillateSettings()) {
    (view as? ScintillateSwizzlerKebab)?.swizzle()

    let parsed = parse(view, apply: {
      $0.dull()
      $0.theShining(with: settings)
    })

    if showLogs {
      os_log("kickStart parsed: %@", parsed)
    }

    reallyOn = true
  }

  /**
   Ends the scintillating effect of the subviews in the provided view.

   - Parameters:
     - view: the root view whose subviews are recursively parsed out, for the purpose of removing the
       scintillating effect.
   */
  public static func shutDown(in view: Scintillatable) {
    (view as? ScintillateSwizzlerKebab)?.deswizzle()

    let parsed = parse(view, apply: { $0.dull() })

    if showLogs {
      os_log("shutDown parsed: %@", parsed)
    }

    reallyOn = false
  }

  /// s/o for already implementing this recursion in [DesignReviewer](https://github.com/alexslee/DesignReviewer/)...
  @discardableResult
  internal static func parse(_ view: Scintillatable, apply: ((Scintillatable) -> Void)?) -> [Scintillatable] {
    var newScintillatables = [Scintillatable]()

    for subScintillatable in view.subScintillables {
      if subScintillatable.isOnScreen {
        newScintillatables.append(subScintillatable)
      }

      if subScintillatable.subScintillables.isEmpty {
        apply?(subScintillatable)
        continue
      }

      newScintillatables.append(contentsOf: parse(subScintillatable, apply: apply))
    }

    return newScintillatables
  }
}
