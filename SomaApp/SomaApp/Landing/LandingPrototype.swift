//
//  LandingPrototype.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import UIKit

final class LandingPrototype: UIViewController {
  
  let headerView = LandingHeaderView()
  let stackView = UIStackView()
  let scrollView = UIScrollView()
  
  let tiles = [
    TileVC("Who is Soma"),
    TileVC("The Mission"),
    TileVC("The Vision"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupScrollView()
    style()
    layout()
  }
}

extension LandingPrototype {
  
  private func setupScrollView() {
    scrollView.delegate = self
  }
  
  private func style() {
    view.backgroundColor = .systemBackground
    
//    navigationController?.navigationBar.topItem?.title = "Soma Academy"
    
    headerView.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false

    stackView.axis = .vertical
    stackView.spacing = 20
    
  }
  
  private func layout() {
    
    view.addSubviews(headerView, scrollView)
    scrollView.addSubview(stackView)
    
    for tile in tiles {
      addChildVCs(to: stackView, tile)
    }
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
    ])
  }
}

extension LandingPrototype: UIScrollViewDelegate {
  
}

