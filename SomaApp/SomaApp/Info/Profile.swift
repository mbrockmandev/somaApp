//
//  Profile.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/24/23.
//

import Foundation

struct Profile {
  let name: String
  let image: String
  let locations: [String]
}

enum Profiles {
  static var mattStrack = Profile(name: "Matt Strack", image: "matt_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var garrettMyers = Profile(name: "Garrett Myers", image: "garrett_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var scottEvans = Profile(name: "Scott Evans", image: "scott_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var jeffMolter = Profile(name: "Jeff Molter", image: "jeff_thumb", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var jamesHorne = Profile(name: "James Horne", image: "james_horne_thumb", locations: ["Kokomo, IN"])
  static var danWeirauch = Profile(name: "Dan Weirauch", image: "dan_thumb", locations: ["Kokomo, IN"])
  static var jaredEmfield = Profile(name: "Jared Emfield", image: "jared_emfield_thumb", locations: ["Idaho Falls, ID, Rexburg, ID"])
  static var jamesEmfield = Profile(name: "James Emfield", image: "james_emfield_thumb", locations: ["Idaho Falls, ID, Rexburg, ID"])
}
