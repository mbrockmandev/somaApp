//
//  ListingUIVCPrototype.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit

final class ListingUIVCPrototype: UIViewController {
  
  var collectionView: UICollectionView!
  var model = Model()
  var videos = [Video]()
  
  enum Section: String, CaseIterable {
//    case main
    case first = "Guard"
    case second = "Side Mount"
    case third = "Mount"
    case fourth = "Back Mount"
  }
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Video>! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    model.delegate = self
    model.getVideos()
    configureCollectionView()
    configureDataSource()
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
    collectionView.backgroundColor = .systemMint
    collectionView.register(ListingCVCell.self, forCellWithReuseIdentifier: ListingCVCell.reuseID)
    collectionView.register(ItemSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID)
    collectionView.delegate = self
    
    view.addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    let inset: CGFloat = 8
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset),
    ])
  }
}

extension ListingUIVCPrototype: UICollectionViewDelegate {
  typealias ListingDataSource = UICollectionViewDiffableDataSource<Section, Video>
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Video>(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, video: Video) -> UICollectionViewCell? in
      
        // Get a cell of the desired kind.
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ListingCVCell.reuseID,
        for: indexPath) as? ListingCVCell else { fatalError("Could not create new cell") }
      
        // Populate the cell with our item description.
      cell.set(with: video)
        // Return the cell.
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
    snapshot.appendItems(videos)
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
    
    
    
    
//    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
//                                          heightDimension: .fractionalHeight(1.0))
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//
//    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                           heightDimension: .fractionalWidth(0.2))
//    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                   subitems: [item])
//
//    let section = NSCollectionLayoutSection(group: group)
//    section.orthogonalScrollingBehavior = .paging
//
//    let layout = UICollectionViewCompositionalLayout(section: section)
//
//    return layout
  }
  
}

extension ListingUIVCPrototype: ModelDelegate {
  func videosFetched(_ videos: [Video]) {
    self.videos = videos
    updateData()
  }
}

  //MARK: - Previews
#if DEBUG
import SwiftUI
struct ListingPrototypeControllerPreview<ListingUIVCPrototype: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: ListingUIVCPrototype, context: Context) {
    
  }
  
  let viewController: ListingUIVCPrototype
  
  init(_ builder: @escaping () -> ListingUIVCPrototype) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> ListingUIVCPrototype {
    viewController
  }
}
#endif

struct ListingUIVCPrototype_Previews: PreviewProvider {
  static var previews: some View {
    UIViewControllerPreview {
      let vc = ListingUIVCPrototype()
      return vc
    }
  }
}
