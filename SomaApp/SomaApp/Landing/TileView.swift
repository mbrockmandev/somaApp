//
//  TileVC.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import UIKit

class TileVC: UIViewController {
  
  let label = UILabel()
  
  init(_ text: String) {
    super.init(nibName: nil, bundle: nil)
    label.text = text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemMint
    layout()
  }
}

extension TileVC {
  
  func layout() {
    label.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      view.heightAnchor.constraint(equalToConstant: 300),
    ])
  }
}

#if DEBUG
import SwiftUI
struct TileVCPreview<TileVC: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: TileVC, context: Context) {
    
  }
  
  let viewController: TileVC
  
  init(_ builder: @escaping () -> TileVC) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> TileVC {
    viewController
  }
}
#endif

struct TestPreviews_Previews: PreviewProvider {
  static var previews: some View {
    TileVCPreview {
      let vc = TileVC("Hi there! I have the high ground.")
      return vc
    }
  }
}
