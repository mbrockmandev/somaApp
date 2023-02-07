//
//  Date+Ext.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import Foundation

extension Date {
  func getFormattedDate(format: String) -> String {
    let dateformat = DateFormatter()
    dateformat.dateFormat = format
    return dateformat.string(from: self)
  }
}
