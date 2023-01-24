//
//  InfoView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/24/23.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 20)
          .padding(.horizontal)
          .frame(height: 140.0)
          .hoverEffect(.highlight)
          .shadow(radius: 10)
          .foregroundColor(.teal)
        
        VStack {
          Text("Test")
          Image("soma_red_black")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
        }
        
          
      }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
