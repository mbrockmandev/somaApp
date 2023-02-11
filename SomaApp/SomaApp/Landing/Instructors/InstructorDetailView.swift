//
//  InstructorDetailView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/25/23.
//

import SwiftUI

struct InstructorDetailView: View {
  var profile: Profile
    var body: some View {
      ZStack {
        Color.systemGray
          .opacity(0.2)
          .ignoresSafeArea()
        VStack {
          InstructorDetailContainerView(profile: profile)
        }
        
      }
        
    }
}

struct InstructorDetailContainerView: View {
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

struct InstructorDetailView_Previews: PreviewProvider {
    static var previews: some View {
      InstructorDetailView(profile: Profile.mock[0])
    }
}
