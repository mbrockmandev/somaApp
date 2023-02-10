//
//  InfoDetailView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/25/23.
//

import SwiftUI

struct InfoDetailView: View {
  var profile: Profile
    var body: some View {
      ZStack {
        Color.systemGray
          .opacity(0.2)
          .ignoresSafeArea()
        VStack {
          InfoContainerView(profile: profile)
        }
        
      }
        
    }
}

struct InfoContainerView: View {
  var profile: Profile
  var body: some View {
      VStack {
        
        Image(profile.image)
          .resizable()
          .scaledToFit()
          .padding(.top, 30)
        Spacer()

        Text(profile.name)
          .font(.largeTitle)
        Text(profile.belt)
          .font(.title2)
        Spacer()
        
        ForEach(profile.locations, id: \.self) { location in
          Text(location)
            .font(.body)
        }
        Spacer()
      }
      .padding()
    .background(
      .regularMaterial,
      in: RoundedRectangle(cornerRadius: 8, style: .continuous)
    )
//    .ignoresSafeArea()
  }
}

struct InfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
      InfoDetailView(profile: Profile.mock[0])
    }
}
