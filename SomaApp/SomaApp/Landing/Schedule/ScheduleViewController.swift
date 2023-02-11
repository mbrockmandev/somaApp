//
//  ScheduleViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/10/23.
//
//TODO: Add schedule view to app

import UIKit

class ScheduleViewController: UIViewController {
  
  enum PickedView {
    case today, schedule
  }
  
  var whichView: PickedView = .today {
    didSet {
      setupUIBarButtonItems()
    }
  }
  
  
  let todayViewController = UIViewController()
  let scheduleViewController = UIViewController()
  
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUIBarButtonItems()
    style()
    layout()
  }
}

extension ScheduleViewController {
  func setupUIBarButtonItems() {
    let todayItem = UIAction(title: "Today", image: UIImage(systemName: whichView == .today ? "star.fill" : "star")) { [self] action in
        // trigger refresh of data for ground items
      whichView = .today
    }
    
    let scheduleItem = UIAction(title: "Schedule", image: UIImage(systemName: whichView == .schedule ? "star.fill" : "star")) { [self] action in
        // trigger refresh of data for standing items
      whichView = .schedule
    }
    
    let menu = UIMenu(title: "", children: [todayItem, scheduleItem])
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: menu)
  }
  
  func style() {
    self.addChildVCs(todayViewController)
    todayViewController.view.backgroundColor = .secondarySystemBackground
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 20
    
      // Image
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(systemName: "square.and.arrow.up")
    
      // Label
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.adjustsFontForContentSizeCategory = true
    label.numberOfLines = 0
    label.text = "Schedule View!"
  }
  
  func layout() {
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(label)
    
    todayViewController.view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: todayViewController.view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: todayViewController.view.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: todayViewController.view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
    ])
  }
}

  //MARK: SwiftUI Style Preview for UIKit
#if DEBUG
import SwiftUI
struct ScheduleViewControllerPreview<ScheduleViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: ScheduleViewController, context: Context) { }
  let viewController: ScheduleViewController
  init(_ builder: @escaping () -> ScheduleViewController) { viewController = builder() }
  func makeUIViewController(context: Context) -> ScheduleViewController { viewController }
}

struct ScheduleViewController_Previews: PreviewProvider {
  static var previews: some View {
    ScheduleViewControllerPreview {
      let vc = ScheduleViewController()
      return vc
    }
  }
}
#endif

