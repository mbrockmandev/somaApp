//
//  ListingViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

final class ListingViewController: UIViewController {
  
  var collectionView: UICollectionView!
  var model = Model()
  var guardVideos = [Video]()
  var sideMountVideos = [Video]()
  var mountVideos = [Video]()
  var backMountVideos = [Video]()
  
  enum Section: String, CaseIterable {
    case grd = "Guard"
    case sideMount = "Side Mount"
    case mount = "Mount"
    case backMount = "Back Mount"
  }
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Video>! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .secondarySystemBackground
    
    model.delegate = self
    model.getVideos(from: Constants.GUARD_PLAYLIST_URL, for: .grd)
    model.getVideos(from: Constants.SIDEMOUNT_PLAYLIST_URL, for: .sideMount)
    model.getVideos(from: Constants.MOUNT_PLAYLIST_URL, for: .mount)
    model.getVideos(from: Constants.BACKMOUNT_PLAYLIST_URL, for: .backMount)
    
    configureCollectionView()
    configureDataSource()
    
    addUITweakButton()
  }
  
  private func addUITweakButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(menuBtnPushed))
  }
  
  @objc private func menuBtnPushed(_ sender: UIButton) {
    print("test")
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
    collectionView.backgroundColor = .secondarySystemBackground
    collectionView.register(ListingCVCell.self, forCellWithReuseIdentifier: ListingCVCell.reuseID)
    collectionView.register(ItemSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID)
    collectionView.delegate = self
    
    view.addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: K.inset),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -K.inset),
    ])
  }
}

extension ListingViewController: UICollectionViewDelegate {
  typealias ListingDataSource = UICollectionViewDiffableDataSource<Section, Video>
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Video>(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, video: Video) -> UICollectionViewCell? in
      
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ListingCVCell.reuseID,
        for: indexPath) as? ListingCVCell else { fatalError("Could not create new cell") }
      
      cell.set(with: video)
      return cell
    }
    
    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      
      if let self, let itemSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID, for: indexPath) as? ItemSupplementaryView {
        
        let itemCollection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        itemSupplementaryView.textLabel.text = itemCollection.rawValue
        
        return itemSupplementaryView
      } else {
        return nil
      }
    }
    
    updateData()
  }
  
  private func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Video>()
    
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(guardVideos, toSection: .grd)
    snapshot.appendItems(sideMountVideos, toSection: .sideMount)
    snapshot.appendItems(mountVideos, toSection: .mount)
    snapshot.appendItems(backMountVideos, toSection: .backMount)

    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  //first attempt
//  private func createLayout() -> UICollectionViewCompositionalLayout {
//
//    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.95))
//      let item = NSCollectionLayoutItem(layoutSize: itemSize)
//      item.contentInsets = NSDirectionalEdgeInsets(top: -K.inset, leading: K.inset, bottom: K.inset, trailing: K.inset)
//
//      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.225))
//      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//      let section = NSCollectionLayoutSection(group: group)
//      section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//
//      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(25))
//      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
//      section.boundarySupplementaryItems = [sectionHeader]
//
//      return section
//    }
//
//    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
//  }
  
  //second attempt at layout
  func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.25))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    
    let section = NSCollectionLayoutSection(group: group)
//    section.interGroupSpacing = 4
    section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    
      // Create a supplementary item for the section header
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    section.boundarySupplementaryItems = [header]
    
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let video = dataSource.itemIdentifier(for: indexPath) else { return }
    let urlString = Constants.YT_PLAY_URL + video.videoId + Constants.YT_INLINE_YES
    guard let url = URL(string: urlString) else { return }
//    let request = URLRequest(url: url)
    
    
    let detailVC = DetailViewController()
    detailVC.url = url
    present(detailVC, animated: true)
  }
}

extension ListingViewController: ModelDelegate {

  func videosFetched(_ videos: [Video], type: Section) {
    switch type {
    case .grd:
      guardVideos = videos
    case .sideMount:
      sideMountVideos = videos
    case .mount:
      mountVideos = videos
    case .backMount:
      backMountVideos = videos
    }
    updateData()
  }
}

  //MARK: - Previews
#if DEBUG
import SwiftUI
struct ListingPrototypeControllerPreview<ListingViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: ListingViewController, context: Context) {
    
  }
  
  let viewController: ListingViewController
  
  init(_ builder: @escaping () -> ListingViewController) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> ListingViewController {
    viewController
  }
}
#endif

struct ListingViewController_Previews: PreviewProvider {
  static var previews: some View {
    ListingPrototypeControllerPreview {
      let vc = ListingViewController()
      return vc
    }
  }
}


//import UIKit
//
//class HeaderView: UICollectionReusableView {
//  private let label = UILabel()
//  
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    configureLabel()
//    configureShadow()
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  private func configureLabel() {
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.textAlignment = .center
//    addSubview(label)
//    NSLayoutConstraint.activate([
//      label.leadingAnchor.constraint(equalTo: leadingAnchor),
//      label.trailingAnchor.constraint(equalTo: trailingAnchor),
//      label.topAnchor.constraint(equalTo: topAnchor),
//      label.bottomAnchor.constraint(equalTo: bottomAnchor)
//    ])
//  }
//  
//  private func configureShadow() {
//    layer.shadowColor = UIColor.black.cgColor
//    layer.shadowOffset = CGSize(width: 0, height: 2)
//    layer.shadowRadius = 4
//    layer.shadowOpacity = 0.3
//    layer.masksToBounds = false
//    layer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor
//  }
//  
//  func setText(_ text: String) {
//    label.text = text
//  }
//}
