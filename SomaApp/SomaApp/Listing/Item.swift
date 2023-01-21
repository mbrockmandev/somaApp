//
//  Item.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import Foundation

struct Item: Hashable {
  let id = UUID().uuidString
  let title: String
//  let picture: UIImage
  let section: String
  let url: URL

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.id == rhs.id
  }
  
  func printContents() {
    print("title = \(title), section = \(section), url = \(url)")
  }
}
