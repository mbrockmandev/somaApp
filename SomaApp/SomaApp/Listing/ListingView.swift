  //
  //  ListingView.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/21/23.
  //

import SwiftUI
import AVKit

struct ListingView: View {
  @State private var model = Model()
//  let url = URL(string: "https://www.youtube.com/watch?v=AlPwpt0cgzc&list=PL0iM5DMxYC5lya2dDsNussyA_-2Y7jmmJ&index=1")!
  let url = URL(string: "https://www.youtube.com/embed/QV4_kVIf4V4")!
  
  
  var body: some View {
    NavigationView {
      VStack {
        VideoPlayer(player: AVPlayer(url: url))
          .scaledToFit()
        
      }
    }
    .onAppear {
      model.getVideos()
      print(model.url as Any)
    }
  }
}

struct ListingView_Previews: PreviewProvider {
  static var previews: some View {
    ListingView()
  }
}
