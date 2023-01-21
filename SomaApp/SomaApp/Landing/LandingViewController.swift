  //
  //  LandingViewController.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/19/23.
  //

// TODO: Fix image bug on first load; it does not appear on subsequent changes of paging VC. Not sure why. Look in top left hand corner.
import UIKit

final class LandingViewController: UIViewController {
  
    // embed everything in a scrollview
  let scrollView = UIScrollView()
  
    // top of the page
  let pagingVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
  var topPagingVCs: [UIViewController] = []
  lazy var firstPageVC: UIViewController = {
    makeVC(withImage: "soma_banner")
  }()
  lazy var secondPageVC: UIViewController = {
    makeVC(withImage: "soma_3rd_degree")
  }()
  lazy var thirdPageVC: UIViewController = {
    makeVC(withImage: "soma_prof_garrett")
  }()
  lazy var timer: Timer = {
    setupTimer()
  }()
  var pagingIndex = 0
  
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
    startTimer()
  }
}

  //MARK: - Setup
extension LandingViewController {
  
  private func setupPagingVC() {
    self.addChild(pagingVC)
    pagingVC.dataSource = self
    pagingVC.delegate = self
    pagingVC.view.translatesAutoresizingMaskIntoConstraints = false
    
    topPagingVCs.append(firstPageVC)
    topPagingVCs.append(secondPageVC)
    topPagingVCs.append(thirdPageVC)
    
    pagingVC.setViewControllers([topPagingVCs[0]], direction: .forward, animated: true)
    scrollView.addSubview(pagingVC.view)
    
  }
  
  private func setupTimer() -> Timer {
    let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(flipPage), userInfo: nil, repeats: true)
    return timer
  }
  
  private func startTimer() {
    timer.fire()
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
      pagingVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      pagingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      pagingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      pagingVC.view.heightAnchor.constraint(equalToConstant: 250),
      
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
      pagingIndex = topPagingVCs.count - 1
      return topPagingVCs[pagingIndex]
    }
    pagingIndex = index - 1
    return topPagingVCs[pagingIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = topPagingVCs.firstIndex(of: viewController) else { return nil }
    
    if index == topPagingVCs.count - 1 {
      pagingIndex = 0
      return topPagingVCs[pagingIndex]
    }
    pagingIndex = index+1
    return topPagingVCs[pagingIndex]
  }
  
  @objc private func flipPage() {
    pagingIndex = pagingIndex == topPagingVCs.count - 1 ? 0 : pagingIndex + 1
    pagingVC.setViewControllers([topPagingVCs[pagingIndex]], direction: .forward, animated: true)
  }
}

