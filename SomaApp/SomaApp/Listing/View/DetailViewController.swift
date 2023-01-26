//
//  DetailViewController.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/22/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
  
  var url: URL!
  var webView: WKWebView!
//  let videoTitle: String!
//  let videoId: String!
//  let webView = WKWebView()
  
//  init(videoTitle: String, videoId: String) {
//    self.videoTitle = videoTitle
//    self.videoId = videoId
//    super.init(nibName: nil, bundle: nil)
//  }
  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupWebView()
//    diffWebView()
  }
}

extension DetailViewController {
  func setupWebView() {
    let webConfiguration = WKWebViewConfiguration()
    webConfiguration.allowsInlineMediaPlayback = true
    webConfiguration.allowsAirPlayForMediaPlayback = true
    webConfiguration.allowsPictureInPictureMediaPlayback = true
    webView = WKWebView(frame: self.view.bounds, configuration: webConfiguration)
    view.addSubview(webView)
    let request = URLRequest(url: url)
    webView.load(request)
  }
  
//  func diffWebView() {
//    guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
//
//    view.addSubview(webView)
//    webView.translatesAutoresizingMaskIntoConstraints = false
//    webView.scrollView.isScrollEnabled = false
//    webView.load(URLRequest(url: youtubeURL))
//
//    NSLayoutConstraint.activate([
//      webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      webView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//    ])
//  }

}

