//
//  InfoDetailView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/25/23.
//

import SwiftUI

struct InfoDetailView: View {
    var body: some View {
      ZStack {
        Color.pink
          .opacity(0.2)
          .ignoresSafeArea()
        VStack {
          InfoContainerView()
        }
        
      }
        
    }
}

struct InfoContainerView: View {
  var body: some View {
      VStack {
        Image("matt_thumb")
          .resizable()
          .scaledToFit()
        Spacer()

        Text("Matt Strack")
          .font(.largeTitle)
        Text("Black Belt 2006 - Pedro Sauer")
          .font(.title2)
        Spacer()
        
        Text("Professor Strack began his journey in Gracie Brazilian Jiu-Jitsu in 1997 with Jeff Curran in Chicago, IL. After being introduced to Jeff Curran's instructor, 8th degree Master Pedro Sauer, Matt moved to Salt Lake City, Utah to study exclusively with Master Sauer. After 9 years of training, Matt Strack received his Gracie Brazilian Jiu-Jitsu Black Belt on June 10, 2006 from Master Pedro Sauer, his 3rd degree Professorship in 2015, and his 4th degree from 9th degree Grand Master Relson Gracie.")
          .font(.body)
        Spacer()
      }
      .padding()
    .background(
      .regularMaterial,
      in: RoundedRectangle(cornerRadius: 8, style: .continuous)
    )
  }
}

struct InfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InfoDetailView()
    }
}
