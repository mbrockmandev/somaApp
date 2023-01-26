//
//  Profile.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/24/23.
//

import Foundation

struct Profile: Hashable, CaseIterable {
  static var allCases: [Profile = <#initializer#>]
  
  let name: String
  let image: String
  let belt: String
  let locations: [String]
}

extension Profile {
  static var mattStrack = Profile(name: "Matt Strack", image: "matt_thumb", belt: "Black Belt - Pedro Sauer 2006", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var garrettMyers = Profile(name: "Garrett Myers", image: "garrett_thumb",  belt: "Black Belt - Matt Strack 2021", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var scottEvans = Profile(name: "Scott Evans", image: "scott_thumb",  belt: "Black Belt - Matt Strack 2019", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var jeffMolter = Profile(name: "Jeff Molter", image: "jeff_thumb",  belt: "Brown Belt", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
  static var jamesHorne = Profile(name: "James Horne", image: "james_horne_thumb",  belt: "Black Belt", locations: ["Kokomo, IN"])
  static var danWeirauch = Profile(name: "Dan Weirauch", image: "dan_thumb",  belt: "Brown Belt", locations: ["Kokomo, IN"])
  static var jaredEmfield = Profile(name: "Jared Emfield", image: "jared_emfield_thumb",  belt: "Black Belt - Pedro Sauer 2011", locations: ["Idaho Falls, ID, Rexburg, ID"])
  static var jamesEmfield = Profile(name: "James Emfield", image: "james_emfield_thumb",  belt: "", locations: ["Idaho Falls, ID, Rexburg, ID"])
}
