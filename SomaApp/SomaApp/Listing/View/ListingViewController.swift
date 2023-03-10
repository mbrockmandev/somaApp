  //
  //  ListingViewController.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/22/23.
  //

import UIKit
import SwiftUI

final class ListingViewController: UIViewController {
  
  var collectionView: UICollectionView!
  var model = Model()
  
  let groundSections = [
    Model.Section(uuid: UUID().uuidString, title: "Guard"),
    Model.Section(uuid: UUID().uuidString, title: "Side Mount"),
    Model.Section(uuid: UUID().uuidString, title: "Mount"),
    Model.Section(uuid: UUID().uuidString, title: "Back Mount"),
  ]
  
  let standingSections = [
    Model.Section(uuid: UUID().uuidString, title: "Strikes"),
    Model.Section(uuid: UUID().uuidString, title: "Holds"),
    Model.Section(uuid: UUID().uuidString, title: "Strangles"),
    Model.Section(uuid: UUID().uuidString, title: "Weapons"),
  ]
  
  var dataSource: UICollectionViewDiffableDataSource<Model.Section, Video>! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .secondarySystemBackground
    model.delegate = self
    model.downloadData(for: model.currentSubset)
    
    model.whichMonth = (Int(Date().getFormattedDate(format: "M")) ?? 0) % 4
    
    configureCollectionView()
    configureDataSource()
    
    addMenu()
    configureUI()
  }
  
  private func configureUI() {
    let backgroundImageView = UIImageView(image: UIImage(named: "soma_red_black"))
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    backgroundImageView.contentMode = .scaleAspectFill
    backgroundImageView.layer.opacity = 0.3
    backgroundImageView.layer.zPosition = -1
    
    view.addSubviews(collectionView, backgroundImageView)
    turnTamicOffFor(backgroundImageView, collectionView)
        
    NSLayoutConstraint.activate([
      backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: K.inset),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset * 2),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -K.inset),
    ])
    
  }

  private func addMenu() {
    let groundItem = UIAction(title: "Ground", image: UIImage(systemName: model.currentSubset == .ground ? "star.fill" : "star")) { [self] action in
        // trigger refresh of data for ground items
      model.currentSubset = .ground
      model.downloadData(for: model.currentSubset)
    }
    
    let standingItem = UIAction(title: "Standing", image: UIImage(systemName: model.currentSubset == .ground ? "star" : "star.fill")) { [self] action in
        // trigger refresh of data for standing items
      model.currentSubset = .standing
      model.downloadData(for: model.currentSubset)
    }
      
    let menu = UIMenu(title: "", children: [groundItem, standingItem])
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: menu)
  }
  
  
}

extension ListingViewController: UICollectionViewDelegate {
  typealias ListingDataSource = UICollectionViewDiffableDataSource<Model.Section, Video>
  
  func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.265))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 80
    section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 24, bottom: 2, trailing: 6)
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    
      // Create a supplementary item for the section header
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    section.boundarySupplementaryItems = [header]
    
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
    collectionView.register(ListingCVCell.self)
    collectionView.backgroundColor = .clear
    collectionView.register(ItemSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID)
    collectionView.delegate = self
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let video = dataSource.itemIdentifier(for: indexPath) else { return }
    
    // swiftui version
    let detailVC = UIHostingController(rootView: ListingDetailView(title: video.title, videoId: video.videoId))
    show(detailVC, sender: nil)
    
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Model.Section, Video>(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, video: Video) -> UICollectionViewCell? in
      
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ListingCVCell.reuseID,
        for: indexPath) as? ListingCVCell else { fatalError("Could not create new cell") }
      
      cell.set(with: video)
      return cell
    }
    
    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      
      if let self, let itemSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ItemSupplementaryView.reuseID, for: indexPath) as? ItemSupplementaryView {
        
        let _ = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        var sectionIndex = self.model.whichMonth + indexPath.section - 1
        if sectionIndex > 3 { sectionIndex = 0 } //hacky way to get rid of out of index error
        
        switch self.model.currentSubset {
        case .standing:
          itemSupplementaryView.textLabel.text = self.standingSections[sectionIndex].title
        case .ground:
          itemSupplementaryView.textLabel.text = self.groundSections[sectionIndex].title
        }
        
        return itemSupplementaryView
      } else {
        return nil
      }
    }
    updateData()
  }
  
  private func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Model.Section, Video>()
    
    switch model.currentSubset {
    case .ground:
      snapshot.appendSections(groundSections)
      snapshot.appendItems(model.guardVideos, toSection: groundSections[0])
      snapshot.appendItems(model.sideMountVideos, toSection: groundSections[1])
      snapshot.appendItems(model.mountVideos, toSection: groundSections[2])
      snapshot.appendItems(model.backMountVideos, toSection: groundSections[3])
    case .standing:
      snapshot.appendSections(standingSections)
      snapshot.appendItems(model.strikeVideos, toSection: standingSections[0])
      snapshot.appendItems(model.holdVideos, toSection: standingSections[1])
      snapshot.appendItems(model.strangleVideos, toSection: standingSections[2])
      snapshot.appendItems(model.weaponVideos, toSection: standingSections[3])
    }
    Task { @MainActor in
      dataSource.apply(snapshot, animatingDifferences: true)
      addMenu()
    }
  }
}

extension ListingViewController: ModelDelegate {
  
  func videosFetched(_ videos: [Video], type: Model.VideoType) {
    
    if model.currentSubset == .standing {
      switch type {
      case .strike:
        model.strikeVideos = videos
      case .hold:
        model.holdVideos = videos
      case .strangle:
        model.strangleVideos = videos
      case .weapon:
        model.weaponVideos = videos
      default:
        break
      }
    } else {
      switch type {
      case .guard:
        model.guardVideos = videos
      case .sideMount:
        model.sideMountVideos = videos
      case .mount:
        model.mountVideos = videos
      case .backMount:
        model.backMountVideos = videos
      default:
        break
      }
    }
    
    updateData()
  }
}

  //MARK: SwiftUI Style Preview for UIKit
#if DEBUG
import SwiftUI

struct ListingPreviews: PreviewProvider {
  static var previews: some View {
    SomaTabControllerPreview {
      let vc = SomaTabController()
      vc.selectedIndex = 1
      return vc
    }
  }
}
#endif


