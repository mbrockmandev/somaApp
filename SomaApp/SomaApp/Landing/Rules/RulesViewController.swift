//
//  RulesViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/7/23.
//

//TODO: add rules from the website

import UIKit

class RulesViewController: UIViewController {
  
  private var tableView: UITableView!
  private var expandedSection: Int?
  var rules = [
    "Keep your gi clean",
    "Show up on time",
    "Be respectful",
    "Trim your nails",
    "No rolling with other inexperienced white belts",
  ]
  
  var sections = [
    "Hygiene",
    "Humility",
    "Respect",
  ]
  
  let titleLabel = UILabel()
  let backgroundImageView = UIImageView()
  let subtitleLabel = UILabel()
  let bodyLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    style()
    layout()
  }
}

extension RulesViewController {
  private func setupTableView() {
    tableView = UITableView(frame: .zero)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(RuleCell.self)
  }
  func style() {
    view.backgroundColor = .systemBackground
    
    // soma
    titleLabel.text = "Soma Academy"
    titleLabel.textAlignment = .center
    titleLabel.font = .preferredFont(forTextStyle: .largeTitle).bold()
    
    // logo
    backgroundImageView.contentMode = .scaleAspectFit
    backgroundImageView.image = UIImage(named: "soma_red_black")
    backgroundImageView.layer.opacity = 0.1
  }
  
  func layout() {
    turnTamicOffFor(tableView, titleLabel, backgroundImageView)
    view.addSubviews(tableView, titleLabel, backgroundImageView)
        
    NSLayoutConstraint.activate([
      backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      backgroundImageView.heightAnchor.constraint(equalToConstant: 240),
      backgroundImageView.widthAnchor.constraint(equalToConstant: 300),
      
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.inset),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: K.inset),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.inset),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -K.inset),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -K.inset),
      
      
    ])
  }
}

extension RulesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RuleCell.reuseID, for: indexPath) as! RuleCell
    let rule = rules[indexPath.item]
    cell.configure(with: rule)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rules.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections.randomElement()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

#if DEBUG
import SwiftUI
struct RulesViewControllerPreview<RulesViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: RulesViewController, context: Context) {
    
  }
  
  let viewController: RulesViewController
  
  init(_ builder: @escaping () -> RulesViewController) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> RulesViewController {
    viewController
  }
}
#endif

struct RulesViewControllerPreviews_Previews: PreviewProvider {
  static var previews: some View {
    RulesViewControllerPreview {
      let vc = RulesViewController()
      return vc
    }
  }
}
