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
  lazy var timer: Timer = {
    setupTimer()
  }()
  var bannerIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    startTimer()
    style()
  }
}

extension LandingViewController {
  private func setupViews() {
    let scrollView = UIScrollView()
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
    
    let contentView = UIView()
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { make in
      make.top.bottom.equalTo(scrollView)
      make.leading.trailing.equalTo(view)
    }

    contentView.addSubviews(bannerImageView)
    
    bannerImageView.image = vm.banners[0]
    
    bannerImageView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(contentView).inset(16)
      make.height.equalTo(240)
    }
    bannerImageView.contentMode = .scaleAspectFill
    bannerImageView.layer.cornerRadius = 5
    bannerImageView.clipsToBounds = true
    bannerImageView.backgroundColor = .systemRed.withAlphaComponent(0.2)
    
    let backgroundImageView = UIImageView()
    view.addSubview(backgroundImageView)
    backgroundImageView.image = UIImage(named: "soma_red_black")
    backgroundImageView.snp.makeConstraints { make in
      make.centerX.centerY.equalTo(view)
//      make.top.equalTo(bannerImageView.snp.bottom).offset(16)
      make.height.width.equalTo(240)
    }
    view.sendSubviewToBack(backgroundImageView)
    
    let label = UILabel()
    contentView.addSubview(label)
    label.text = "I fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefijI fpwoijefpoqijweopfijqwpeofijqwopefijqwopeifjqpefij"
    label.numberOfLines = 0
    label.font = .preferredFont(forTextStyle: .title1)
    label.snp.makeConstraints { make in
      make.top.equalTo(bannerImageView.snp.bottom)
      make.leading.trailing.equalTo(contentView).inset(16)
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

extension LandingViewController: UIScrollViewDelegate {
  
}
