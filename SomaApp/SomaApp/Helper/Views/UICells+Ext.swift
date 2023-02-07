//
//  UITableViewCell+Ext.swift
//  SomaApp
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

extension UICollectionViewCell {
  
  static var reuseID: String {
    String(describing: self)
  }
  
  var reuseID: String {
    type(of: self).reuseID
  }
}

public extension UITableView {
  
  func register<T: UITableViewCell>(_ type: T.Type) {
    register(T.self, forCellReuseIdentifier: T.reuseID)
  }
  
  func reuse<T: UITableViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
    dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as! T
  }
}

public extension UICollectionView {
  
  func register<T: UICollectionViewCell>(_ type: T.Type) {
    register(T.self, forCellWithReuseIdentifier: T.reuseID)
  }
  
  func reuse<T: UICollectionViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
    dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as! T
  }
}
