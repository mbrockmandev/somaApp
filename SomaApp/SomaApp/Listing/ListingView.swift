  //
  //  ListingView.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/21/23.
  //

import SwiftUI
import AVKit

struct ListingView: View, ModelDelegate {

  @State private var model = Model()
  @State private var videos = [Video]()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(videos) { video in
          Text(video.title)
        }
      }
      
        //      VStack {
        //        VideoPlayer(player: AVPlayer(url: model.response.items[0].))
        //          .scaledToFit()
        //      }
    }
    .onAppear {
      model.getVideos()
    }
  }
  
  func videosFetched(_ videos: [Video]) {
    self.videos = videos
    dump(videos)
  }
}

struct ListingView_Previews: PreviewProvider {
  static var previews: some View {
    ListingView()
  }
}
