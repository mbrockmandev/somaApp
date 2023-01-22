//
//  UIView+Ext.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: [UIView]) {
    for subview in subviews {
      addSubview(subview)
    }
  }
  
  func addSubviews(_ subviews: UIView...) {
    for subview in subviews {
      addSubview(subview)
    }
  }
}

extension UIStackView {
  func addArrangedSubviews(_ subviews: [UIView]) {
    for subview in subviews {
      addArrangedSubview(subview)
    }
  }
  
  func addArrangedSubviews(_ subviews: UIView...) {
    for subview in subviews {
      addArrangedSubview(subview)
    }
  }
}

extension UIViewController {
  func add(_ children: UIViewController...) {
    for child in children {
      addChild(child)
      view.addSubview(child.view)
      child.didMove(toParent: self)
    }
  }
  
  func remove() {
    guard parent != nil else { return }
    
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}
