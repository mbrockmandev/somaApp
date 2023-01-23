  //
  //  LandingViewController.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/19/23.
  //

// TODO: Fix image bug on first load; it does not appear on subsequent changes of paging VC. Not sure why. Look in top left hand corner.
import UIKit

final class LandingViewController: UIViewController {
  
  let aboutText: [String] = [
    "Who is Soma Academy?",
    "A nationwide Gracie Brazilian Jiu-Jitsu association under the guidance of 4th Degree Gracie Jiu-Jitsu Black Belt, Professor Matt Strack, who received his black belt from 8th degree Master Pedro Sauer in 2006. Professor Strack is currently a 4th degree black belt from 9th degree Grand Master Relson Gracie.",
    "What is the mission of Soma Academy?",
    "To provide quality instruction to our students in a clean, inclusive, family friendly environment, through curriculum driven, effective, real world self-defense techniques that are not based on size, strength, athletic ability, or time limits.",
    "The Vision:",
    "To unlock the full potential of our students.",
    "Why \"Soma?\"",
    "The word 'Soma' comes from from Greek sōma ‘body’ and is used in our name because Jiu-Jitsu is not only known as one of the most effective forms of martial arts, but is also one of the earliest forms of exercise or physical fitness in existence, providing for a complete workout of the body and mind.",
    
  ]
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
  
  let imageView = UIImageView()
  let label = UILabel()
  
    // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupScrollView()
    setupPagingVC()
    configureVC()
    startTimer()
  }
}

  //MARK: - Setup
extension LandingViewController {
  
  private func setupPagingVC() {
    self.addChild(pagingVC)
    pagingVC.dataSource = self
    pagingVC.delegate = self
    pagingVC.view.frame = .zero
    
    topPagingVCs.append(firstPageVC)
    topPagingVCs.append(secondPageVC)
    topPagingVCs.append(thirdPageVC)
    
    pagingVC.setViewControllers([topPagingVCs[0]], direction: .forward, animated: true)
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
    scrollView.isScrollEnabled = true
  }
  
  private func configureVC() {
    view.backgroundColor = .systemBackground
    
    let containerView = UIView()
    containerView.frame = view.bounds
    containerView.backgroundColor = .systemBackground
    scrollView.frame = view.frame
    scrollView.contentSize = view.frame.size
    
    let questionBtnOne = UIButton(configuration: .borderedProminent())
    questionBtnOne.translatesAutoresizingMaskIntoConstraints = false
    questionBtnOne.setTitle(aboutText[0], for: .normal)
    
    pagingVC.view.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
  
    view.addSubviews(containerView)
    containerView.addSubviews(scrollView)
    scrollView.addSubviews(pagingVC.view, questionBtnOne)
    
    NSLayoutConstraint.activate([
      
      containerView.topAnchor.constraint(equalTo: view.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      scrollView.topAnchor.constraint(equalTo: containerView.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      
      pagingVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
      pagingVC.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      pagingVC.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      pagingVC.view.heightAnchor.constraint(equalToConstant: 250),
      
      questionBtnOne.topAnchor.constraint(equalTo: pagingVC.view.bottomAnchor),
      questionBtnOne.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      questionBtnOne.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      questionBtnOne.heightAnchor.constraint(equalToConstant: 60),
      
    ])
  }
}

//MARK: - ScrollView Methods
extension LandingViewController: UIScrollViewDelegate {

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


//MARK: - Previews
#if DEBUG
import SwiftUI
struct UIViewControllerPreview<LandingViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: LandingViewController, context: Context) {
    
  }
  
  let viewController: LandingViewController
  
  init(_ builder: @escaping () -> LandingViewController) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> LandingViewController {
    viewController
  }
}
#endif

struct LandingViewController_Previews: PreviewProvider {
  static var previews: some View {
    UIViewControllerPreview {
      let vc = LandingViewController()
      return vc
    }
  }
}
