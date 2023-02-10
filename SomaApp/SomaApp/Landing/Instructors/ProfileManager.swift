//
//  ProfileFileManager.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/26/23.
//

import Foundation

struct ProfileManager {
  private init() {}
  
  static func readData() -> [Profile] {
    do {
      let fileURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("profiles.json")
      print(fileURL)
      
      let data = try Data(contentsOf: fileURL)
      dump(data)
      let profileData = try JSONDecoder().decode([Profile].self, from: data)
      dump(profileData)
      return profileData
      
    } catch {
      print(error)
      return []
    }
  }
}
