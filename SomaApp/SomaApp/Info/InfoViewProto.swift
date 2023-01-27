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
      Text("Instructors")
        .largeSectionModifier()
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 16) {
          ForEach(profiles, id: \.self) { profile in
            ProfileViewProto(profile: profile)
              .padding(.top)
          }
        }
        Spacer() //replace with other content later
      }
    }
  }
}

struct ProfileViewProto: View {
  var profile: Profile
  @State private var isShowingDetail = false
  @Environment(\.sizeCategory) var sizeCategory
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 8) {
      
      RoundedRectangle(cornerRadius: 20)
        .fill(.black.opacity(0.1))
        .overlay(Image(profile.image)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(.linearGradient(colors: [.primary.opacity(0.3), .secondary.opacity(0.1)], startPoint: .bottom, endPoint: .top)))
          .frame(width: 250, height: 105))
        .cornerRadius(20)
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
    .frame(width: 240, height: sizeCategory > .large ? 300 : 240)
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


