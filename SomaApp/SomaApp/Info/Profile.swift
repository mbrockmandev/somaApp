//
//  Profile.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/24/23.
//

import Foundation

struct Profile {
  let name: String
  let profile: String
  let locations: [String]
}

enum Profiles {
  static var mattStrack = Profile(name: "Matt Strack", profile: "matt_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var garrettMyers = Profile(name: "Garrett Myers", profile: "garrett_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var scottEvans = Profile(name: "Scott Evans", profile: "scott_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var jeffMolter = Profile(name: "Jeff Molter", profile: "jeff_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var jamesHorne = Profile(name: "James Horne", profile: "james_horne_thumb", locations: ["Kokomo, IN"])
  static var danWeirauch = Profile(name: "Dan Weirauch", profile: "dan_thumb", locations: ["Kokomo, IN"])
  static var jaredEmfield = Profile(name: "Jared Emfield", profile: "jared_emfield_thumb", locations: ["Idaho Falls, ID, Rexburg, ID"])
  static var jamesEmfield = Profile(name: "James Emfield", profile: "james_emfield_thumb", locations: ["Idaho Falls, ID, Rexburg, ID"])
}
