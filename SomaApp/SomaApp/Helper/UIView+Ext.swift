//
//  UIView+Ext.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//
/// convenience extensions used for UIView, UIStackView, UIViewController

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
  func addChildVCs(_ children: UIViewController...) {
    for child in children {
      addChild(child)
      view.addSubview(child.view)
      child.didMove(toParent: self)
    }
  }
  
  func addChildVCs(to stack: UIStackView, _ children: UIViewController...) {
    for child in children {
      addChild(child)
      stack.addArrangedSubview(child.view)
      child.didMove(toParent: self)
    }
  }
  
  func remove() {
    guard parent != nil else { return }
    
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
  
  ///Sets translatesAutoresizingMaskIntoConstraints = false
  ///Works on any UIView, and accepts variadic views.
  func turnTamicOffFor(_ views: UIView...) {
    for view in views {
      view.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  ///Applies NSLayoutConstraints to all four edges of the superView (UIViewController)
  func pinToEdges(_ views: UIView...) {
    for view in views {
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: self.view.topAnchor),
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      ])
    }
  }
}

