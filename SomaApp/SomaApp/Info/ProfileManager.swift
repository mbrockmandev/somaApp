//
//  ProfileFileManager.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/26/23.
//

import Foundation

struct ProfileManager {
  init() {}
  static func writeData(_ profiles: [Profile]) -> Void {
    do {
      let fileURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("profiles.json")
      try JSONEncoder().encode(profiles).write(to: fileURL)
        
    } catch {
      print(error)
    }
  }
  
  
  static func readData() -> [Profile] {
    do {
      let fileURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("profiles.json")
      
      let data = try Data(contentsOf: fileURL)
      let profileData = try JSONDecoder().decode([Profile].self, from: data)
      
      return profileData
      
    } catch {
      print(error)
      return []
    }
  }
}
