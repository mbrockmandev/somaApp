  //
  //  ListingDetailView.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/25/23.
  //

import SwiftUI
import WebKit

struct ListingDetailView: View {
  let title: String
  let videoId: String
  
  var body: some View {
    ZStack {
      LinearGradient(
        colors: [.red.opacity(0.3), .black.opacity(0.3)],
        startPoint: .top,
        endPoint: .bottom
      ).ignoresSafeArea()
      EmbedFrameView(title: title, videoId: videoId)
    }
  }
}

struct EmbedView: UIViewRepresentable {
  let videoId: String
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
    uiView.scrollView.isScrollEnabled = false
    uiView.load(URLRequest(url: youtubeURL))
  }
}

struct EmbedFrameView: View {
  let title: String
  let videoId: String
  
  var body: some View {
    GeometryReader { proxy in
      
      VStack(alignment: .center) {
        Spacer()
        Text(title)
          VStack {
            EmbedView(videoId: videoId)
              .frame(maxWidth: .infinity, maxHeight: proxy.size.height / 3)
              .cornerRadius(8)
          }
        
        .frame(maxWidth: .infinity, maxHeight: proxy.size.height / 3)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(.black.opacity(0.7), lineWidth: 3)
        )
        .background(Color.white)
        .cornerRadius(10)
        Spacer()
        Spacer()
      }
      .background(
        LinearGradient(colors: .init([Color("F6E0BB"), Color("E5E5E5"), Color("E5E5E5")]), startPoint: .top, endPoint: .bottom))
    }
    .padding(.horizontal)
  }
}

struct ListingDetailView_Previews: PreviewProvider {
  
  static var previews: ListingDetailView {
    ListingDetailView(title: "Video Title", videoId: "kkBB8afMliY")
  }
}
