//
//  CacheManager.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import Foundation

final class CacheManager {
  init() {}
  static var cache = [String: Data]()
  static func setVideoCache(_ url: String, data: Data) {
    cache[url] = data
  }
  
  static func getVideoCache(_ url: String) -> Data? {
    cache[url]
  }
}
