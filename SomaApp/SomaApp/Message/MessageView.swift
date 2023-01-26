//
//  MessageView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/26/23.
//

import SwiftUI

struct MessageView: View {
  var body: some View {
    ZStack {
      Color.red
        .opacity(0.4)
        .ignoresSafeArea()
      VStack {
        Text("Messaging to come!")
        Text("Probably going to use FCM (firebase)")
      }
      .bold()
      .shadow(radius: 5, y: 5)
    }
  }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
