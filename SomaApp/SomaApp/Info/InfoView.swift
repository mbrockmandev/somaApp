  //
  //  InfoView.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/24/23.
  //

import SwiftUI

struct InfoView: View {
    //  var profiles: [Profile]
  @State private var currentZoom = 0.0
  @State private var finalZoom = 1.0
  
  var body: some View {
    ZStack {
      Color.secondary
      List {
        ProfileView(profile: Profiles.mattStrack)
          .cornerRadius(10)
        ProfileView(profile: Profiles.garrettMyers)
        ProfileView(profile: Profiles.scottEvans)
      }

    }
    .padding(.vertical)
    .ignoresSafeArea()
  }
}

struct ProfileView: View {
  var profile: Profile
  @State private var isShowingDetail = false
  
  var body: some View {
    ZStack {
      Color.pink
        .opacity(0.2)
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
            .cornerRadius(5)
            .onTapGesture {
              // present detail view?
              isShowingDetail = true
            }
        }
        .cornerRadius(10)
        .frame(maxWidth: 300, maxHeight: 240)
        
        Spacer()
          .frame(height: 20)
        VStack(spacing: 6) {
          Text(profile.name)
            .font(.title)
            .bold()
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
    .shadow(radius: 10)
    .cornerRadius(10)
    .sheet(isPresented: $isShowingDetail) {
      InfoDetailView()
    }
  }
}

struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
      //      InfoView(profiles: [Profiles.mattStrack])
    InfoView()
  }
}
