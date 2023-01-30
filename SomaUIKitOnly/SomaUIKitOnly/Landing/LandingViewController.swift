  //
  //  LandingViewController.swift
  //  SomaUIKitOnly
  //
  //  Created by Michael Brockman on 1/29/23.
  //

import UIKit
import SnapKit

//MARK: - LandingElementType
enum LandingCellType: String {
  case banner
  case card
}

protocol LandingModel: AnyObject {
  var type: LandingCellType { get }
}

protocol LandingCell: AnyObject {
  func configure(with elementModel: LandingModel)
}

class LandingViewController: UIViewController {
  
  let vm = LandingViewModel()

  let tableView = UITableView()
  
  var landingElements = [LandingModel]()

  lazy var timer: Timer = {
    setupTimer()
  }()
  var bannerIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupElements()
    setupViews()
    startTimer()
    style()
  }
}

extension LandingViewController {
  private func setupElements() {
//    var bannerElements = [BannerElement]()
    for banner in vm.banners {
      landingElements.append(BannerElement(image: banner))
    }
//    var cardElements = [CardElement]()
    for card in vm.cards {
      landingElements.append(CardElement(text: card))
    }
    
  }
  
  private func setupViews() {

    tableView.delegate = self
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    let backgroundImageView = UIImageView()
    view.addSubview(backgroundImageView)
    backgroundImageView.image = UIImage(named: "soma_red_black")
    backgroundImageView.snp.makeConstraints { make in
      make.centerX.centerY.equalTo(view)
      make.height.width.equalTo(240)
    }
    view.sendSubviewToBack(backgroundImageView)
    


  }
  
  private func setupTimer() -> Timer {
    let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changeBannerImage), userInfo: nil, repeats: true)
    return timer
  }
  
  private func startTimer() {
    timer.fire()
  }
  
  private func stopTimer() {
    timer.invalidate()
  }
  
  @objc private func changeBannerImage() {
    
//    if bannerIndex < vm.banners.count - 1 {
//      bannerIndex += 1
//    } else {
//      bannerIndex = 0
//    }
    
//    let currentPos = bannerImageView.layer.position
//    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [self] in
//      bannerImageView.alpha = 0
//    } completion: { [self] _ in
//      bannerImageView.image = vm.banners[bannerIndex]
//    }
//
//    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [self] in
//      bannerImageView.alpha = 1
//    }


    
  }
  
  private func style() {
    view.backgroundColor = .secondarySystemBackground

    
  }
  
}

extension LandingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return landingElements.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cellModel = landingElements[indexPath.row]
    let cellIdentifier = cellModel.type.rawValue
    let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LandingCell
    
    customCell.configure(with: cellModel)
    
    return customCell as! UITableViewCell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    //more logic to come
  }
  
}
