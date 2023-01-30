  //
  //  LandingViewController.swift
  //  SomaUIKitOnly
  //
  //  Created by Michael Brockman on 1/29/23.
  //

import UIKit
import SnapKit

class LandingViewController: UIViewController {
  
  let vm = LandingViewModel()

  let bannerImageView = UIImageView()
  let tableView = UITableView()

  lazy var timer: Timer = {
    setupTimer()
  }()
  var bannerIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Test!")
    setupBannerView()
    setupTableView()
    startTimer()
    style()
  }
}

extension LandingViewController {
  private func setupBannerView() {
    view.addSubview(bannerImageView)
    bannerImageView.image = vm.banners[0]
    
    bannerImageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalTo(view).inset(16)
      make.height.equalTo(240)
    }
    bannerImageView.contentMode = .scaleAspectFill
    bannerImageView.layer.cornerRadius = 5
  }
  
  private func setupTableView() {

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(LandingCardCell.self)
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(bannerImageView.snp.bottom).offset(16)
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
    
    if bannerIndex < vm.banners.count - 1 {
      bannerIndex += 1
    } else {
      bannerIndex = 0
    }
    
    let currentPos = bannerImageView.layer.position
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [self] in
      bannerImageView.alpha = 0
    } completion: { [self] _ in
      bannerImageView.image = vm.banners[bannerIndex]
    }

    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [self] in
      bannerImageView.alpha = 1
    }
    
  }
  
  private func style() {
    view.backgroundColor = .secondarySystemBackground

    
  }
  
}

extension LandingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vm.cards.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: LandingCardCell.reuseID, for: indexPath) as! LandingCardCell
    
    cell.configure(with: vm.cards[indexPath.row])
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    //more logic to come
  }

  
}
