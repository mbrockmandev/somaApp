//
//  Profile.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/24/23.
//

import Foundation

struct Profile: Codable, Hashable {
  let id = UUID().uuidString
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: Profile, rhs: Profile) -> Bool {
    lhs.id == rhs.id
  }
  
  let name: String
  let image: String
  let belt: String
  let locations: [String]
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case image
    case belt
    case locations
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.name = try container.decode(String.self, forKey: .name)
    self.image = try container.decode(String.self, forKey: .image)
    self.belt = try container.decode(String.self, forKey: .belt)
    self.locations = try container.decode([String].self, forKey: .locations)
  }
  
  init(name: String, image: String, belt: String, locations: [String]) {
    self.name = name
    self.image = image
    self.belt = belt
    self.locations = locations
  }
  
  static let mock = Profile(name: "Matt", image: "matt_thumb", belt: "Black Belt", locations: ["Dayton, OH"])
}

