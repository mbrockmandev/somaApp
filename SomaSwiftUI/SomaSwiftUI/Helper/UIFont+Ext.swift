//
//  UIFont+Ext.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

extension UIFont {
  func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    let descriptor = fontDescriptor.withSymbolicTraits(traits)
    return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
  }
  
  func bold() -> UIFont {
    return withTraits(traits: .traitBold)
  }
  
  func italic() -> UIFont {
    return withTraits(traits: .traitItalic)
  }
}

