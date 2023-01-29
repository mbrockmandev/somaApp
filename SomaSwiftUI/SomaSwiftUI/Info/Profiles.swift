//
//  Profiles.swift
//  SomaSwiftUI
//
//  Created by Michael Brockman on 1/28/23.
//

import Foundation

struct Profile: Decodable, Hashable, Identifiable {
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: Profile, rhs: Profile) -> Bool {
    lhs.id == rhs.id
  }
  
  let id: String
  let name: String
  let image: String
  let belt: String
  let locations: [String]
  
  enum CodingKeys: String, CodingKey {
      // container
    case profiles
    
    case id, name, image, belt
    case locations
  }
  
  static let mock = [Profile(id: "01", name: "Matt Strack", image: "matt_thumb", belt: "Black Belt - Pedro Sauer - 2006", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"]),
                     Profile(id: "02", name: "Garrett Myers", image: "garrett_thumb", belt: "Black Belt - Matt Strack - 2021", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"]),
                     Profile(id: "03", name: "Scott Evans", image: "scott_thumb", belt: "Black Belt - Matt Strack - 2019", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"]),
                     Profile(id: "04", name: "Jeff Molter", image: "jeff_thumb", belt: "Brown Belt - Matt Strack", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"]),
                     Profile(id: "05", name: "James Horne", image: "james_horne_thumb", belt: "Black Belt - Matt Strack", locations: ["Kokomo, IN"]),
                     Profile(id: "06", name: "Dan Weirauch", image: "dan_thumb", belt: "Brown Belt", locations: ["Kokomo, IN"]),
                     Profile(id: "07", name: "Jared Emfield", image: "jared_emfield_thumb", belt: "Black Belt - Pedro Sauer - 2011", locations: ["Idaho Falls, ID", "Rexburg, ID"]),
                     Profile(id: "08", name: "James Emfield", image: "james_emfield_thumb", belt: "A Belt", locations: ["Idaho Falls, ID", "Rexburg, ID"]),
  ]
}

extension Profile {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let profilesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .profiles)
    
    self.id = try profilesContainer.decode(String.self, forKey: .id)
    self.name = try profilesContainer.decode(String.self, forKey: .name)
    self.image = try profilesContainer.decode(String.self, forKey: .image)
    self.belt = try profilesContainer.decode(String.self, forKey: .belt)
    self.locations = try profilesContainer.decode([String].self, forKey: .locations)
  }
}
