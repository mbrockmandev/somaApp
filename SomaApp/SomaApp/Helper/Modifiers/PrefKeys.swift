//
//  PrefKeys.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/27/23.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
