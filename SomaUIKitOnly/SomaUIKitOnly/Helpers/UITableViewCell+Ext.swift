//
//  UITableViewCell+Ext.swift
//  SomaUIKitOnly
//
//  Created by Michael Brockman on 1/30/23.
//

import UIKit

extension UITableViewCell {
  
  static var reuseID: String {
    String(describing: self)
  }
  
  var reuseID: String {
    type(of: self).reuseID
  }
}
