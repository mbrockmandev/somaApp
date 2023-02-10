  //
  //  InstructorView.swift
  //  SomaApp
  //
  //  Created by Michael Brockman on 1/27/23.
  //

import SwiftUI

struct InstructorView: View {
  @State private var profiles = Profile.mock
  @State var hasScrolled = false
  
  var body: some View {
    
      ZStack {
        Color.black.opacity(0.05)
          .ignoresSafeArea()
          .background(.ultraThinMaterial)
        ScrollView {
          VStack(alignment: .leading) {
            Text("Instructors")
              .largeSectionModifier()
              .offset(y: 20)
            scrollDetection
            ZStack {
              Image("soma_red_black")
              featured
            }
          }
          
        }
        .padding()
        .shadow(radius: 20)
      }
      
    
    
  }
  
  var scrollDetection: some View {
    GeometryReader { proxy in
      Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
    }
    .frame(height: 0)
    .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
      withAnimation(.easeInOut) {
        if value < 0 {
          hasScrolled = true
        } else {
          hasScrolled = false
        }
      }
    })
  }
  
  var featured: some View {
    TabView {
      ForEach(profiles) { profile in
        GeometryReader { proxy in
          let minX = proxy.frame(in: .global).minX
          ProfileViewProto(profile: profile)
            .padding()
            .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
            .blur(radius: abs(minX / 100))
        }
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
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
            .stroke(.linearGradient(colors: [.primary.opacity(0.3), .secondary.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)))
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
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
    .background(.ultraThinMaterial)
    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
      .stroke(.linearGradient(colors: [.primary.opacity(0.3), .secondary.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)))
    .sheet(isPresented: $isShowingDetail) {
      InfoDetailView(profile: profile)
    }
    
  }
}

struct InstructorView_Previews: PreviewProvider {
  static var previews: some View {
    InstructorView()
  }
}


