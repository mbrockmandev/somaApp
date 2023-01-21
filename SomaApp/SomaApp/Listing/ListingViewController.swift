//
//  ListingViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/19/23.
//

import UIKit

final class ListingViewController: UIViewController {
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  var items: [Item] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getItems()
    setupCollectionView()
    configureDataSource()
    updateData(in: Section.allCases, with: items)
  }
  
  private func getItems() {
//    print(#function)
    for i in 1...10 {
      let title = "Item \(i)"
      guard let url = URL(string: "https://www.google.com") else { return }
      guard let section = Section.allCases.randomElement() else { return }
      items.append(Item(title: title, section: section.rawValue, url: url))
    }
//    items.forEach { $0.printContents() }
  }
  
}

//MARK: - Collection View and Data Source Setup
extension ListingViewController {
  typealias ItemDataSource = UICollectionViewDiffableDataSource<Section, Item>
  
  private func setupCollectionView() {
//    print(#function)
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureCollectionViewLayout())
    collectionView.delegate = self
    collectionView.register(ItemSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID)
    collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseID)
    collectionView.backgroundColor = .systemMint
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
    ])
    
  }
  
  private func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
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
  
//  func configureDataSource() {
//    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
//      print(item)
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseID, for: indexPath) as! ItemCell
//      cell.set(with: item)
//      print(cell.label.text as Any)
//      return cell
//    })
//
//    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
//      if let self, let itemSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID, for: indexPath) as? ItemSupplementaryView {
//        let itemCollection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
//        itemSupplementaryView.textLabel.text = itemCollection.rawValue
//
//        return itemSupplementaryView
//      } else {
//        return nil
//      }
//    }
//  }
  
  func configureDataSource() {
//    print(#function)
    dataSource = ItemDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseID, for: indexPath) as? ItemCell else {
        return nil
      }
      
      cell.set(with: item)
      print(cell.label.text as Any)
      return cell
    })
    
    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      
      if let self, let itemSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID, for: indexPath) as? ItemSupplementaryView {
        
        let itemCollection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        itemSupplementaryView.textLabel.text = itemCollection.rawValue
        
        return itemSupplementaryView
      } else {
        return nil
      }
    }
  }
  
  func updateData(in sections: [Section], with items: [Item]) {
//    print(#function)
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    
    snapshot.appendSections(sections)
    snapshot.appendItems(items)
//    items.forEach { $0.printContents() }
    Task { @MainActor in
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
    
}

//MARK: - CV Delegate
extension ListingViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(#function)
    // transition to detail view for the video
  }
}

//MARK: - Previews
#if DEBUG
import SwiftUI
struct UIViewControllerPreview<ListingViewController: UIViewController>: UIViewControllerRepresentable {
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
    UIViewControllerPreview {
      let vc = ListingViewController()
      return vc
    }
  }
}
