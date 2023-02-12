//
//  RulesView.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/11/23.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
      ZStack {
        Image("soma_crest")
          .resizable()
          .frame(maxWidth: 300, maxHeight: 320)
          .opacity(0.8)
        VStack {
          // text and stuff to come?
        }
      }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
