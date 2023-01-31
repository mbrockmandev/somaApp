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

  let scrollView = UIScrollView()
  let stackView = UIStackView()
  let bannerImageView = UIImageView()
  let tableView = UITableView(frame: .init(x: 0, y: 0, width: 390, height: 400), style: .plain)
  let label = makeLabel(withText: "qpwoefijqwopefij qwopfijqwpeofijqwopefijqpweofijqwepfoij qwepfoijqwepfoiqjefopijqwefopiqjwefopiqjefpoiq wejfpoiqwejfpoiqefjopqweifjpoqweifjqopweifjpqweoifjqwopeifjqpwoefijqpwe ofijqwepoifjqpoefijqpeofijqwpeofijqpweofijqwef")

  lazy var timer: Timer = {
    setupTimer()
  }()
  var bannerIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBackgroundImageView()
    setupScrollView()
    setupBannerView()
    setupTableView()
    startTimer()
    style()
    let stackViewSize = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    scrollView.contentSize = stackViewSize
    
  }

}

extension LandingViewController {
  private func setupBackgroundImageView() {
    let backgroundImageView = UIImageView()
    view.addSubview(backgroundImageView)
    backgroundImageView.image = UIImage(named: "soma_red_black")
    backgroundImageView.snp.makeConstraints { make in
      make.centerX.centerY.equalTo(view)
      make.height.width.equalTo(240)
    }
    view.sendSubviewToBack(backgroundImageView)
  }
  
  private func setupScrollView() {

    scrollView.isDirectionalLockEnabled = true
    scrollView.showsVerticalScrollIndicator = true
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.isScrollEnabled = true
    
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.alignment = .fill
    stackView.spacing = 8

    stackView.backgroundColor = .systemPink.withAlphaComponent(0.3)
    
    view.addSubview(scrollView)
    scrollView.addSubview(stackView)
    stackView.addArrangedSubviews(bannerImageView, tableView, label)
    
    scrollView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    stackView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(scrollView)
      make.width.equalTo(scrollView.snp.width)
    }
    
  }
  
  private func setupBannerView() {
    bannerImageView.image = vm.banners[0]
    
    bannerImageView.snp.makeConstraints { make in
        //TODO: leave room for buttons at top?

//      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.height.equalTo(240)
//      make.width.equalTo(360)
    }
    bannerImageView.contentMode = .scaleAspectFill
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(LandingCardCell.self)
    tableView.rowHeight = UITableView.automaticDimension
    
    tableView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(scrollView).inset(8)
//      make.top.equalTo(bannerImageView.snp.bottom).offset(16).priority(.required)
      make.height.equalTo(view.snp.height).multipliedBy(0.48)
    }
    tableView.layer.cornerRadius = 20
    
    //TODO: REMOVE
    label.numberOfLines = 0
    label.font = .preferredFont(forTextStyle: .largeTitle)
    // just for testing
    
    
    label.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
    }
    
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
    
//    let currentPos = bannerImageView.layer.position
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
