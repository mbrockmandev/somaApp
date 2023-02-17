//
//  Class.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/14/23.
//

import Foundation

struct Class: Hashable {
  let time: String
  let title: String
  let ageGroup: String
}

extension Class {
  static let DaytonClasses = [
    Class(time: "11AM to 12PM", title: "Foundations", ageGroup: "Adult (16+)"),
    Class(time: "12PM to 12:30PM", title: "Open Mat", ageGroup: "Adult (16+)"),
    Class(time: "4:30PM to 5PM", title: "Little Porcupines", ageGroup: "3-6"),
    Class(time: "5PM to 5:45PM", title: "Juniors 1", ageGroup: "7-10"),
    Class(time: "5PM to 5:45PM", title: "Juniors 2", ageGroup: "11-15"),
    Class(time: "6PM to 7PM", title: "Foundations", ageGroup: "Adult (16+)"),
    Class(time: "7PM to 715PM", title: "Open Mat", ageGroup: "Adult (16+)"),
    Class(time: "715PM to 815PM", title: "Advanced", ageGroup: "Adult, 3+ stripes"),
  ]
  
  static let OxfordClasses = [
    Class(time: "7PM to 8PM", title: "Foundations", ageGroup: "Adult (16+)"),
    Class(time: "8PM to 830PM", title: "Open Mat", ageGroup: "Adult (16+)")
  ]
}
