//
//  InfoView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/24/23.
//

import SwiftUI

struct InfoView: View {
//  var profiles: [Profile]
  
    var body: some View {
      ZStack {
        Color.secondary
        List {
          ProfileView(profile: Profiles.mattStrack)
            .onTapGesture {
              
            }
          ProfileView(profile: Profiles.garrettMyers)
          ProfileView(profile: Profiles.scottEvans)
        }
      }
    }
}

struct ProfileView: View {
  var profile: Profile
  
  var body: some View {
    ZStack {
      Color.red
        .opacity(0.4)
      VStack {
        ZStack {
          RoundedRectangle(cornerRadius: 5)
            .padding(.horizontal)
            .foregroundColor(.secondary)
            .border(.thinMaterial, width: 2)
          
          Image(profile.image)
            .resizable()
            .scaledToFill()
            .border(.thinMaterial)
            .cornerRadius(10)
          
        }
        .frame(maxWidth: 300, maxHeight: 240)
        
        Spacer()
          .frame(height: 20)
        VStack(spacing: 6) {
          Text(profile.name)
            .font(.title)
            .bold()
            .shadow(radius: 1)
          
            .frame(height: 20)
          Spacer()
            .frame(height: 20)
          ForEach(profile.locations, id:\.self) { location in
            Text(location)
              .foregroundColor(.secondary)
              .bold()
          }
          
        }
      }
      .padding(10)
    .shadow(radius: 10)
    }
  }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
//      InfoView(profiles: [Profiles.mattStrack])
      InfoView()
    }
}
