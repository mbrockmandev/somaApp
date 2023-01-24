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
  
  enum Section: String, CaseIterable {
    case first
    case second
    case third
    case fourth
  }
  
  enum Subset {
    case ground
    case standing
  }
  
  var whichMonth: Int!
  let sectionNames = ["Guard", "Side Mount", "Mount", "Back Mount"]
  var currentSubset: Subset = .ground
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Video>! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .secondarySystemBackground
    model.delegate = self
    
    downloadData(for: currentSubset)
    
    configureCollectionView()
    configureDataSource()
    
    addMenu()
  }
  
  private func downloadData(for subset: Subset) {
    guard let month = Int(Date().getFormattedDate(format: "M")) else { return }
    // soma uses a 4 month rotation for the schedule
    whichMonth = month % 4
    
    // order the videos into sections based on the month (i.e., this follows the curriculum at soma)
    switch subset {
    case .ground:
      switch whichMonth {
      case 0:
        model.getVideos(from: Constants.GUARD_PLAYLIST_URL, for: .first)
        model.getVideos(from: Constants.SIDEMOUNT_PLAYLIST_URL, for: .second)
        model.getVideos(from: Constants.MOUNT_PLAYLIST_URL, for: .third)
        model.getVideos(from: Constants.BACKMOUNT_PLAYLIST_URL, for: .fourth)
      case 1:
        model.getVideos(from: Constants.GUARD_PLAYLIST_URL, for: .second)
        model.getVideos(from: Constants.SIDEMOUNT_PLAYLIST_URL, for: .third)
        model.getVideos(from: Constants.MOUNT_PLAYLIST_URL, for: .fourth)
        model.getVideos(from: Constants.BACKMOUNT_PLAYLIST_URL, for: .first)
      case 2:
        model.getVideos(from: Constants.GUARD_PLAYLIST_URL, for: .third)
        model.getVideos(from: Constants.SIDEMOUNT_PLAYLIST_URL, for: .fourth)
        model.getVideos(from: Constants.MOUNT_PLAYLIST_URL, for: .first)
        model.getVideos(from: Constants.BACKMOUNT_PLAYLIST_URL, for: .second)
      case 3:
        model.getVideos(from: Constants.GUARD_PLAYLIST_URL, for: .fourth)
        model.getVideos(from: Constants.SIDEMOUNT_PLAYLIST_URL, for: .first)
        model.getVideos(from: Constants.MOUNT_PLAYLIST_URL, for: .second)
        model.getVideos(from: Constants.BACKMOUNT_PLAYLIST_URL, for: .third)
      default:
        break
      }
    
    case .standing:
      switch whichMonth {
      case 0:
        model.getVideos(from: Constants.STRIKE_PLAYLIST_URL, for: .first)
        model.getVideos(from: Constants.HOLD_PLAYLIST_URL, for: .second)
        model.getVideos(from: Constants.STRANGLE_PLAYLIST_URL, for: .third)
        model.getVideos(from: Constants.WEAPON_PLAYLIST_URL, for: .fourth)
      case 1:
        model.getVideos(from: Constants.STRIKE_PLAYLIST_URL, for: .second)
        model.getVideos(from: Constants.HOLD_PLAYLIST_URL, for: .third)
        model.getVideos(from: Constants.STRANGLE_PLAYLIST_URL, for: .fourth)
        model.getVideos(from: Constants.WEAPON_PLAYLIST_URL, for: .first)
      case 2:
        model.getVideos(from: Constants.STRIKE_PLAYLIST_URL, for: .third)
        model.getVideos(from: Constants.HOLD_PLAYLIST_URL, for: .fourth)
        model.getVideos(from: Constants.STRANGLE_PLAYLIST_URL, for: .first)
        model.getVideos(from: Constants.WEAPON_PLAYLIST_URL, for: .second)
      case 3:
        model.getVideos(from: Constants.STRIKE_PLAYLIST_URL, for: .fourth)
        model.getVideos(from: Constants.HOLD_PLAYLIST_URL, for: .first)
        model.getVideos(from: Constants.STRANGLE_PLAYLIST_URL, for: .second)
        model.getVideos(from: Constants.WEAPON_PLAYLIST_URL, for: .third)
      default:
        break
      }
      
    }
      
    

  }
  
  private func addMenu() {
    let groundItem = UIAction(title: "Ground") { [self] action in
      // trigger refresh of data for ground items
      currentSubset = .ground
      downloadData(for: currentSubset)
    }
    
    let standingItem = UIAction(title: "Standing") { [self] action in
      // trigger refresh of data for standing items
      currentSubset = .standing
      downloadData(for: currentSubset)
    }
    
    let menu = UIMenu(title: "", children: [groundItem, standingItem])
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: menu)
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
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset * 2),
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
        
        let _ = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let sectionIndex = self.whichMonth + indexPath.section - 1
        itemSupplementaryView.textLabel.text = self.sectionNames[sectionIndex]
        
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
    
    switch currentSubset {
    case .ground:
      snapshot.appendItems(model.guardVideos, toSection: .first)
      snapshot.appendItems(model.sideMountVideos, toSection: .second)
      snapshot.appendItems(model.mountVideos, toSection: .third)
      snapshot.appendItems(model.backMountVideos, toSection: .fourth)
    case .standing:
      snapshot.appendItems(model.strikeVideos, toSection: .first)
      snapshot.appendItems(model.holdVideos, toSection: .second)
      snapshot.appendItems(model.strangleVideos, toSection: .third)
      snapshot.appendItems(model.weaponVideos, toSection: .fourth)
    }
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let video = dataSource.itemIdentifier(for: indexPath) else { return }
    let urlString = Constants.YT_PLAY_URL + video.videoId + Constants.YT_INLINE_YES
    guard let url = URL(string: urlString) else { return }
    
    let detailVC = DetailViewController()
    detailVC.url = url
    present(detailVC, animated: true)
  }
}

extension ListingViewController: ModelDelegate {

  func videosFetched(_ videos: [Video], type: Section) {
    switch currentSubset {
      
    case .ground:
      switch type {
      case .first:
        model.guardVideos = videos
      case .second:
        model.sideMountVideos = videos
      case .third:
        model.mountVideos = videos
      case .fourth:
        model.backMountVideos = videos
      }
    case .standing:
      switch type {
      case .first:
        model.strikeVideos = videos
      case .second:
        model.holdVideos = videos
      case .third:
        model.strangleVideos = videos
      case .fourth:
        model.weaponVideos = videos
      }
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
