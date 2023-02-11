//
//  InfoView.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/11/23.
//
//TODO: Build out info view

import SwiftUI

struct InfoView: View {
    var body: some View {
      ZStack {
        Color.tertiaryLabel
          .ignoresSafeArea()
        Text("Info view!")
      }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
