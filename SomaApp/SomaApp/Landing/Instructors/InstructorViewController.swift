  //
  //  InfoVCTest.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/28/23.
  //
//TODO: WIP. SwiftUI Version was much easier to build and cannot see a reason to use UIKit over it. Probably scrap this file.
import UIKit

class InstructorViewController: UIViewController {
  
  let backgroundImageView = UIImageView(image: UIImage(named: "soma_red_black"))
  
  let profiles = Profile.mock
  var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    layout()
  }
  
  private func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.estimatedItemSize = .init(width: view.frame.width - K.inset * 4, height: 280)
    
    collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 390 * 2, height: 280), collectionViewLayout: layout)
    collectionView.backgroundColor = .secondarySystemBackground
    collectionView.register(InstructorCell.self)
    collectionView.delegate = self
  }
  
  private func layout() {
    turnTamicOffFor(backgroundImageView, collectionView)
    view.addSubviews(backgroundImageView, collectionView)
    
    NSLayoutConstraint.activate([
      backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.inset),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: K.inset),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -K.inset),
      collectionView.heightAnchor.constraint(equalToConstant: 380)
    ])
  }
}

extension InstructorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print(#function)
    return profiles.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print(#function)
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstructorCell.reuseID, for: indexPath) as? InstructorCell else { fatalError("Could not create instructor cell") }
//    cell.set(with: profiles[indexPath.item])
    return cell
  }
}

#if DEBUG
import SwiftUI
struct InstructorViewControllerPreview<InstructorViewController: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: InstructorViewController, context: Context) {}
  let viewController: InstructorViewController
  init(_ builder: @escaping () -> InstructorViewController) {viewController = builder()}
  func makeUIViewController(context: Context) -> InstructorViewController {viewController}
}
#endif
struct TestPreviews_Previews: PreviewProvider {
  static var previews: some View {
    InstructorViewControllerPreview {
      let vc = InstructorViewController()
      return vc
    }
  }
}
