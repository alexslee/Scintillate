//
//  ScintillateSwizzlerKebab.swift
//  
//
//  Created by Alex Lee on 4/2/22.
//

import Foundation

/**
 _(Had to make the pun, IYKYK)_ Internal protocol to clean up swizzling of methods cross-platform.
 */
internal protocol ScintillateSwizzlerKebab {
  /// Swizzles the necessary methods.
  func swizzle()
  /// Removes any currently swizzled implementations.
  func deswizzle()
}
