  //
  //  InfoViewProto.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/27/23.
  //

import SwiftUI

struct InfoViewProto: View {
  @State private var profiles = Profile.mock
  
  var body: some View {

      NavigationStack {
        

        ZStack {
          TabView {
                  ForEach(profiles, id: \.self) { profile in
                    GeometryReader { proxy in
                      ProfileViewProto(profile: profile)
                        .padding()
                    }
                  }
                }
                .background {
                  Image("soma_red_black")
                }
              .tabViewStyle(.page(indexDisplayMode: .never))
        }

        
      }
  }
}

struct ProfileViewProto: View {
  var profile: Profile
  @State private var isShowingDetail = false
  @Environment(\.sizeCategory) var sizeCategory
  
  var body: some View {
    
      VStack(alignment: .center, spacing: 8) {
        
        RoundedRectangle(cornerRadius: 20)
          .fill(.black.opacity(0.1))
          .overlay(Image(profile.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
              .stroke(.linearGradient(colors: [.primary.opacity(0.3), .secondary.opacity(0.1)], startPoint: .bottom, endPoint: .top)))
              .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
          )
          .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
          .padding([.top, .horizontal])
          .onTapGesture {
            isShowingDetail = true
          }
        Text(profile.belt.uppercased())
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
          .padding(.leading)
        Text(profile.name)
          .fontWeight(.semibold)
          .padding(.leading)
      }
      .padding(.bottom)
      .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
//      .frame(width: 350, height: sizeCategory > .large ? 480 : 360)
      .background(.ultraThinMaterial)
      .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
      .shadow(radius: 20)
      .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
        .stroke(.linearGradient(colors: [.primary.opacity(0.3), .secondary.opacity(0.1)], startPoint: .bottom, endPoint: .top)))
      .navigationDestination(isPresented: $isShowingDetail) {
        InfoDetailView(profile: profile)
    }
    
  }
}

struct InfoViewProto_Previews: PreviewProvider {
  static var previews: some View {
    InfoViewProto()
  }
}


