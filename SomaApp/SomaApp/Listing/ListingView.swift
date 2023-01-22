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
  @State private var items = [Video]()
  @State private var testItems = ["One", "Two", "Three"]
  
  var body: some View {
    NavigationView {
      List {
        if let items = model.response?.items {
          ForEach(items) { item in
            Text(item.title)
          }
        } else {
          ForEach(testItems, id:\.self) { item in
            Text(item)
          }
        }
      }
//      VStack {
//        VideoPlayer(player: AVPlayer(url: model.response.items[0].))
//          .scaledToFit()
//      }
    }
    .onAppear {
      model.getVideos()
      guard model.response?.items != nil else { return }
      items = (model.response?.items)!
    }
  }
}

struct ListingView_Previews: PreviewProvider {
  static var previews: some View {
    ListingView()
  }
}
