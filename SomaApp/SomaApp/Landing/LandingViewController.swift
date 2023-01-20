//
//  LandingViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/19/23.
//

import UIKit

class LandingViewController: UIViewController {
  
  let pagingVC = UIPageViewController()
  var topPagingVCs: [UIViewController] = []
  lazy var firstPageVC: UIViewController = {
    makeVC(withColor: .systemMint)
  }()
  lazy var secondPageVC: UIViewController = {
    makeVC(withColor: .systemPurple)
  }()
  lazy var thirdPageVC: UIViewController = {
    makeVC(withColor: .systemPink)
  }()
  
  let scrollView = UIScrollView()
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPagingVC()
    setupScrollView()
    style()
    layout()
  }
}

extension LandingViewController {
  private func setupPagingVC() {
    self.addChild(pagingVC)
    pagingVC.dataSource = self
    pagingVC.delegate = self
    
    topPagingVCs.append(firstPageVC)
    topPagingVCs.append(secondPageVC)
    topPagingVCs.append(thirdPageVC)
    
    pagingVC.setViewControllers(topPagingVCs, direction: .forward, animated: true)
    view.addSubview(pagingVC.view)
    pagingVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width * 0.8, height: 200)
    
  }
  private func setupScrollView() {
    scrollView.delegate = self
    view.addSubview(scrollView)
    scrollView.frame = view.frame
    scrollView.contentSize = view.frame.size
    scrollView.isScrollEnabled = true
    
  }
  
  private func style() {
    view.backgroundColor = .systemBackground
    
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
    label.text = "LANDING"
  }
  
  private func layout() {
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(label)
    scrollView.addSubview(stackView)
    view.addSubview(scrollView)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
    ])
  }
}

extension LandingViewController: UIScrollViewDelegate {
  
}

extension LandingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    <#code#>
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    <#code#>
  }
  
  @objc private func flipPage() {
    
  }
  
}


