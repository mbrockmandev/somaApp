//
//  LandingViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//
///basically the new landing view controller
///
import UIKit

final class LandingViewController: UIViewController {
  
  let stackView = UIStackView()
  let scrollView = UIScrollView()
  
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
  
  // Tiles for the stack view
  let tiles = [
    TileVC("Who is Soma"),
    TileVC("The Mission"),
    TileVC("The Vision"),
  ]
  
  lazy var blurView: UIView = {
    makeBlurView()
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupScrollView()
    setupBackgroundImageBlur()
    setupPagingVC()
    style()
    layout()
    startTimer()
  }
}

extension LandingViewController {
  
  private func setupScrollView() {
    scrollView.delegate = self
    scrollView.isDirectionalLockEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
  }
  
  private func setupBackgroundImageBlur() {
    

  }
  
  private func setupPagingVC() {
    self.addChild(pagingVC)
    pagingVC.dataSource = self
    pagingVC.delegate = self
    pagingVC.view.frame = .zero
    pagingVC.view.contentMode = .scaleAspectFill
    
    topPagingVCs.append(firstPageVC)
    topPagingVCs.append(secondPageVC)
    topPagingVCs.append(thirdPageVC)
    
    pagingVC.setViewControllers([topPagingVCs[0]], direction: .forward, animated: true)
  }
  
  private func setupTimer() -> Timer {
    let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(flipPage), userInfo: nil, repeats: true)
    return timer
  }
  
  private func startTimer() {
    timer.fire()
  }
  
  private func stopTimer() {
    timer.invalidate()
  }
  
  private func style() {
    view.backgroundColor = .systemBackground
    
    navigationController?.navigationBar.topItem?.title = "Soma Academy"
    
    turnTamicOffFor(stackView, scrollView, pagingVC.view)

    stackView.axis = .vertical
    stackView.spacing = 32
    
  }
  
  private func layout() {
    
    let backgroundImageView = UIImageView(image: UIImage(named: "soma_red_black"))
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    backgroundImageView.contentMode = .scaleAspectFill
    
    view.addSubviews(scrollView)
    scrollView.addSubviews(pagingVC.view, stackView, backgroundImageView)
    scrollView.sendSubviewToBack(backgroundImageView)
    
    for tile in tiles {
      addChildVCs(to: stackView, tile)
      tile.index = tiles.firstIndex(of: tile)
    }
    
    print("content size: \(scrollView.contentSize)")

    
    pinToEdges(scrollView)
    NSLayoutConstraint.activate([
      
      pagingVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
      pagingVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: K.inset),
      pagingVC.view.heightAnchor.constraint(equalToConstant: 190),
      pagingVC.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: K.inset * -3),
      
      stackView.topAnchor.constraint(equalTo: pagingVC.view.bottomAnchor, constant: K.inset * 2),
      stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: K.inset * -4),
      
      backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}

extension LandingViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.x != 0 {
      scrollView.contentOffset.x = 0
    }
  }
}

  //MARK: - Page VC Methods
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
