//
//  TileVC.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import UIKit

class TileVC: UIViewController {
  
  let label = UILabel()
  let button = UIButton(configuration: .borderedTinted())
  let imageView: UIImageView? = nil
  
  init(_ text: String) {
    super.init(nibName: nil, bundle: nil)
    label.text = text
  }
  
  init(_ text: String, image: UIImage) {
    super.init(nibName: nil, bundle: nil)
    label.text = text
    imageView?.image = image
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGroupedBackground
    layout()
    setupImageView()
  }
}

extension TileVC {
  
  private func layout() {
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    view.layer.shadowRadius = 10
    view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      view.heightAnchor.constraint(equalToConstant: 240),
    ])
  }
  
  private func setupImageView() {
    guard let imageView else { return }
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
