  //
  //  LandingViewController.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/19/23.
  //

import UIKit

class LandingViewController: UIViewController {
  
    // embed everything in a scrollview
  let scrollView = UIScrollView()
  
    // top of the page
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
  lazy var timer: Timer = {
    setupTimer()
  }()
  
    // use a stack view for the rest of the elements in the page
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
    // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupScrollView()
    setupPagingVC()
    style()
    layout()
  }
}

  //MARK: - Setup
extension LandingViewController {
  
  private func setupPagingVC() {
    self.addChild(pagingVC)
    pagingVC.dataSource = self
    pagingVC.delegate = self
    
    topPagingVCs.append(firstPageVC)
    topPagingVCs.append(secondPageVC)
    topPagingVCs.append(thirdPageVC)
    
    pagingVC.setViewControllers([topPagingVCs[0]], direction: .forward, animated: true)
    scrollView.addSubview(pagingVC.view)
    let pagingVCInitialX = 32
    
    pagingVC.view.frame = CGRect(x: pagingVCInitialX, y: 24, width: Int(view.frame.size.width - 64), height: 200)
    
  }
  
  private func setupTimer() -> Timer {
    let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(flipPage), userInfo: nil, repeats: true)
    return timer
  }
  
  private func stopTimer() {
    timer.invalidate()
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
    guard let index = topPagingVCs.firstIndex(of: viewController) else { return nil }
    if index == 0 {
      return topPagingVCs[topPagingVCs.count - 1]
    }
    return topPagingVCs[index-1]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = topPagingVCs.firstIndex(of: viewController) else { return nil }
    if index == topPagingVCs.count - 1 {
      return topPagingVCs[0]
    }
    return topPagingVCs[index+1]
  }
  
  @objc private func flipPage() {
    
    
  }
}

