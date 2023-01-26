  //
  //  InfoView.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/24/23.
  //

import SwiftUI

struct InfoView: View {
  @State private var profiles = [Profile]()
  
  var body: some View {
    
    NavigationStack {
      
      ZStack {
        Color.red.opacity(0.4)
          .ignoresSafeArea()
          .background(.regularMaterial)
        
        VStack {
          List {
            ForEach(Staff.allCases, id: \.self) { member in
              InfoDetailView(profile: member)
            }
          }
          .listStyle(.sidebar)
          .cornerRadius(10)
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
        .navigationTitle("Soma")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.vertical)
      }
    }
  }
  
  private func getProfiles() {
    ForEach(Profile.allCases) { profile in
      profiles.append(profile)
    }
  }
}

struct ProfileView: View {
  var profile: Profile
  @State private var isShowingDetail = false
  
  var body: some View {
    HStack {
      ZStack {
        Color.red
          .opacity(0.4)
          .ignoresSafeArea()
          .background(.ultraThinMaterial)
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
              .frame(height: 10)
            Spacer()
              .frame(height: 20)
          }
        }
          //        .padding(10)
        .shadow(radius: 10)
      }
      .shadow(radius: 10)
      .cornerRadius(10)
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
