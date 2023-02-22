//
//  RuleCell.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/20/23.
//

import UIKit

class RuleCell: UITableViewCell {
  var bodyText = UILabel()
  var isExpanded: Bool = false {
    didSet {
      // update cell UI based on expansion
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }
  
  func configure(with rule: String) {
    bodyText.text = rule
    //TODO: Need body text to appear on cell 
  }
  
  private func configureUI() {
    contentView.addSubview(bodyText)
    bodyText.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bodyText.topAnchor.constraint(equalTo: topAnchor),
      bodyText.leadingAnchor.constraint(equalTo: leadingAnchor),
      bodyText.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
