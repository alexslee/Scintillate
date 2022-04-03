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

  private static var reallyOn = false

  internal static var showLogs = false

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

  public static func shutDown(in view: Scintillatable) {
    (view as? ScintillateSwizzlerKebab)?.deswizzle()

    let parsed = parse(view, apply: { $0.dull() })

    if showLogs {
      os_log("shutDown parsed: %@", parsed)
    }

    reallyOn = false
  }

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
