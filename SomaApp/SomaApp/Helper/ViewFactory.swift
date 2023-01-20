//
//  ViewFactory.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/20/23.
//

import UIKit

func makeVC(withColor color: UIColor) -> UIViewController {
  let vc = UIViewController()
  vc.view.translatesAutoresizingMaskIntoConstraints = false
  vc.view.backgroundColor = color
  
  return vc
}

func makeLabel(withText text: String) -> UILabel {
  let label = UILabel()
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = text
  label.textColor = .label
  label.font = UIFont.preferredFont(forTextStyle: .body)
  
  return label
}

func makeSubLabel(withText text: String) -> UILabel {
  let label = UILabel()
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = text
  label.textColor = .label
  label.font = UIFont.preferredFont(forTextStyle: .subheadline)
  label.numberOfLines = 0 // multiline
  
  return label
}

func makeBoldLabel(withText text: String) -> UILabel {
  let label = UILabel()
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = text
  label.textColor = .white
  label.font = UIFont.boldSystemFont(ofSize: 18)
  
  return label
}
