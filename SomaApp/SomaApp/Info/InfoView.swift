  //
  //  InfoView.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/24/23.
  //

import SwiftUI

struct InfoView: View {
  @State private var profiles = Profile.mock
  
  var body: some View {
    
    NavigationStack {
      
      ZStack {
        HStack {
          ScrollView() {
            ForEach(profiles, id: \.self) { profile in
              ProfileView(profile: profile)
            }
          }
          
          .listStyle(.inset)
          .listRowBackground(Color.secondarySystemBackground)
        }
        .toolbar {
          ToolbarItemGroup {
              //
          } label: {
            Menu {
                //
            } label: {
              Image(systemName: "location.square")
            }
          }
        }
        
        .padding(.vertical)
      }
    }
  }
}

struct ProfileView: View {
  var profile: Profile
  @State private var isShowingDetail = false
  
  var body: some View {
    HStack {
      ZStack {
        Color.secondarySystemBackground
//          .opacity(0.4)
          .ignoresSafeArea()
          .background(.thickMaterial)
        VStack {
          ZStack {
            Rectangle()
              .foregroundColor(.secondary)
              .border(.thinMaterial, width: 5)
              .shadow(radius: 5)
            
            Image(profile.image)
              .resizable()
              .scaledToFill()
              .border(.thickMaterial)
              .cornerRadius(2)
              .onTapGesture {
                isShowingDetail = true
              }
          }
          .padding(.vertical)
          .frame(maxWidth: 300, maxHeight: 240)
          
          VStack(spacing: 6) {
            Text(profile.name)
              .font(.title)
              .bold()
              .frame(height: 10)
            Spacer()
          }
        }
        .shadow(radius: 10)
      }
      .shadow(radius: 10)
//      .cornerRadius(10)
      .navigationDestination(isPresented: $isShowingDetail) {
        InfoDetailView(profile: profile)
      }
    }
  }
}

struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
      //      InfoView(profiles: [Profiles.mattStrack])
    InfoView()
  }
}
