  //
  //  LandingViewPrototype.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/23/23.
  //

  ///
import UIKit
import SwiftUI
import MessageUI

final class LandingViewController: UIViewController {
  
  enum Sections {
    case main
  }
  
  enum Locations {
    case dayton, westChester, oxford, kokomo, idahoFalls, rexburg
  }
  
  var userLocation: Locations = .dayton
  
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
  
  var cv: UICollectionView! = nil
  
  // tiles for the collectionView
  let tiles = [
    "INSTRUCTORS",
    "RULES",
    "SCHEDULE",
    "SHOP",
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addMenu()
    setupPagingVC()
    configureCollectionView()
    style()
    layout()
    startTimer()
  }
}

extension LandingViewController {
  
  /// set location through the context menu in the upper right hand corner
  /// triggers UI updates among other things (TBD)
  private func addMenu() {
    let daytonItem = UIAction(title: "Dayton, OH", image: UIImage(systemName: userLocation == .dayton ? "checkmark.circle.fill" : "")) { [self] action in
      userLocation = .dayton
      // use the location for some reason
    }
    
    let westChesterItem = UIAction(title: "West Chester, OH", image: UIImage(systemName: userLocation == .westChester ? "checkmark" : "")) { [self] action in
      userLocation = .westChester
    }
    
    let oxfordItem = UIAction(title: "Oxford, OH", image: UIImage(systemName: userLocation == .oxford ? "checkmark" : "")) { [self] action in
      userLocation = .oxford
    }
    
    let kokomoItem = UIAction(title: "Kokomo, IN", image: UIImage(systemName: userLocation == .kokomo ? "checkmark" : "")) { [self] action in
      userLocation = .kokomo
    }
    
    let idahoFallsItem = UIAction(title: "Idaho Falls, ID", image: UIImage(systemName: userLocation == .idahoFalls ? "checkmark" : "")) { [self] action in
      userLocation = .idahoFalls
    }
    
    let rexburgItem = UIAction(title: "Rexburg, ID", image: UIImage(systemName: userLocation == .rexburg ? "checkmark" : "")) { [self] action in
      userLocation = .rexburg
    }
    
    let menu = UIMenu(title: "", children: [daytonItem, westChesterItem, oxfordItem, kokomoItem, idahoFallsItem, rexburgItem])
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: menu)
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
  
  private func configureCollectionView() {
    
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    let availableWidth = width - (padding) - (minimumItemSpacing * 2)
    let itemWidth = availableWidth / 2.5
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 24, left: padding * 2, bottom: padding, right: padding * 2)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + (itemWidth * 0.2))
    
    flowLayout.scrollDirection = .vertical
    cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    cv.delegate = self
    cv.dataSource = self
    cv.register(TileCell.self)
    cv.backgroundColor = .clear
    
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
    
    turnTamicOffFor(pagingVC.view, cv)
    
  }
  
  private func layout() {
    
    let backgroundImageView = UIImageView(image: UIImage(named: "soma_red_black"))
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    backgroundImageView.contentMode = .scaleAspectFill
    
    view.addSubviews(pagingVC.view, backgroundImageView, cv)
    view.sendSubviewToBack(backgroundImageView)
  
    NSLayoutConstraint.activate([
      
      pagingVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      pagingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset),
      pagingVC.view.heightAnchor.constraint(equalToConstant: 190),
      pagingVC.view.widthAnchor.constraint(equalTo: view.widthAnchor, constant: K.inset * -3),
      
      backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      cv.topAnchor.constraint(equalTo: pagingVC.view.bottomAnchor, constant: K.inset * 4),
      cv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset),
      cv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset),
      cv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -K.inset),
      
    ])
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

extension LandingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tiles.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TileCell.reuseID, for: indexPath) as! TileCell
    
    cell.set(with: tiles[indexPath.item])
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    
    // redirect to a detail view depending on the tile tapped
    switch indexPath.item {
      
    case 0:
      let detailVC = UIHostingController(rootView: InstructorView())
      show(detailVC, sender: nil)
      
    case 1:
      let detailVC = RulesViewController()
      show(detailVC, sender: nil)
      
    case 2:
      let detailVC = ScheduleViewController()
      show(detailVC, sender: nil)
      
    case 3:
      if let url = URL(string: "https://www.squareup.com/store/Soma_JiuJitsu_Academy/") {
        UIApplication.shared.open(url)
      }

    default:
      break
    }
    
  }
}

//MARK: - SwiftUI Preview for UIKit
#if DEBUG
import SwiftUI
struct LandingViewControllerPreview<LandingViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: LandingViewController, context: Context) { }
  let viewController: LandingViewController
  init(_ builder: @escaping () -> LandingViewController) { viewController = builder() }
  func makeUIViewController(context: Context) -> LandingViewController { viewController }
}

struct LandingViewController_Previews: PreviewProvider {
  static var previews: some View {
    LandingViewControllerPreview {
      let vc = LandingViewController()
      return vc
    }
  }
}
#endif
