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
    
    model.delegate = self
    model.getVideos(from: Constants.GUARD_PLAYLIST_URL, for: .grd)
    model.getVideos(from: Constants.SIDEMOUNT_PLAYLIST_URL, for: .sideMount)
    model.getVideos(from: Constants.MOUNT_PLAYLIST_URL, for: .mount)
    model.getVideos(from: Constants.BACKMOUNT_PLAYLIST_URL, for: .backMount)
    configureCollectionView()
    configureDataSource()
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
    collectionView.backgroundColor = .systemBackground
    collectionView.register(ListingCVCell.self, forCellWithReuseIdentifier: ListingCVCell.reuseID)
    collectionView.register(ItemSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID)
    collectionView.delegate = self
    
    view.addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.inset),
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
  
  
  private func createLayout() -> UICollectionViewLayout {
    
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      section.interGroupSpacing = 10
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      section.boundarySupplementaryItems = [sectionHeader]
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
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

struct ListingUIVCPrototype_Previews: PreviewProvider {
  static var previews: some View {
    ListingPrototypeControllerPreview {
      let vc = ListingViewController()
      return vc
    }
  }
}
