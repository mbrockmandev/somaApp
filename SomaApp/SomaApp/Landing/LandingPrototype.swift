//
//  LandingPrototype.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/23/23.
//

import UIKit

final class LandingPrototype: UIViewController {
  
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
    
    navigationController?.navigationBar.topItem?.title = "Soma Academy"
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false

    stackView.axis = .vertical
    stackView.spacing = 20
    
    

  }
  
  private func layout() {
    
    view.addSubviews(scrollView, stackView)
    
    NSLayoutConstraint.activate([
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
