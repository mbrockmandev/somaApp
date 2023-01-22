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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupWebView()
  }
}

extension DetailViewController {
  func setupWebView() {
    let webConfiguration = WKWebViewConfiguration()
    webConfiguration.allowsInlineMediaPlayback = true
    webConfiguration.allowsAirPlayForMediaPlayback = true
    webConfiguration.allowsPictureInPictureMediaPlayback = true
    Task {
      webView = WKWebView(frame: self.view.bounds, configuration: webConfiguration)
      view.addSubview(webView)
      
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }

}

