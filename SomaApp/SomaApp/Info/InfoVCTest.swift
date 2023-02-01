//
//  InfoVCTest.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/28/23.
//

import UIKit

class InfoVCTest: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    configureView()
  }
  
  private func configureView() {
    let backgroundImageView = UIImageView(image: UIImage(named: "soma_red_black"))
    
    let cardBackgroundView = UIView()
    cardBackgroundView.frame = CGRect(x: 20, y: 20, width: 380, height: 240)
    cardBackgroundView.backgroundColor = .systemGray.withAlphaComponent(0.6)
    cardBackgroundView.clipsToBounds = true
    cardBackgroundView.layer.cornerRadius = 20
    cardBackgroundView.layer.borderWidth = 2
    cardBackgroundView.layer.borderColor = .init(gray: 0.3, alpha: 0.5)
    
    let cardForegroundView = UIView()
    cardForegroundView.frame = CGRect(x: 20, y: 20, width: 380, height: 240)
    cardForegroundView.backgroundColor = .clear
    cardForegroundView.clipsToBounds = true
    cardForegroundView.layer.cornerRadius = 20
//    cardForegroundView.backgroundColor = .systemMint
    
    let profileImageView = UIImageView(frame: cardForegroundView.bounds)
    profileImageView.image = UIImage(named: "matt_thumb")
    profileImageView.contentMode = .scaleAspectFill
    profileImageView.clipsToBounds = true
    profileImageView.layer.cornerRadius = 20
    cardForegroundView.addSubview(profileImageView)
    
    let blurEffect = UIBlurEffect(style: .regular)
    let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
    let blurView = UIVisualEffectView(effect: blurEffect)
    let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
    blurView.frame = cardBackgroundView.bounds
    vibrancyView.frame = cardBackgroundView.bounds
    cardBackgroundView.addSubview(blurView)
    blurView.contentView.addSubview(vibrancyView)

    view.addSubviews(backgroundImageView, cardBackgroundView, cardForegroundView)
    
    turnTamicOffFor(backgroundImageView, cardBackgroundView, cardForegroundView, profileImageView)
    NSLayoutConstraint.activate([
      backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      cardBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.inset*10),
      cardBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.inset*2),
      cardBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.inset*2),
      cardBackgroundView.heightAnchor.constraint(equalToConstant: 240),
      
      cardForegroundView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: K.inset*2),
      cardForegroundView.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: K.inset*4),
      cardForegroundView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -K.inset*4),
      cardForegroundView.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor, constant: -K.inset*4),
      
      profileImageView.topAnchor.constraint(equalTo: cardForegroundView.topAnchor),
      profileImageView.leadingAnchor.constraint(equalTo: cardForegroundView.leadingAnchor),
      profileImageView.trailingAnchor.constraint(equalTo: cardForegroundView.trailingAnchor),
      profileImageView.bottomAnchor.constraint(equalTo: cardForegroundView.bottomAnchor),
      
    ])
    
//    cardForegroundView.pinToEdges(profileImageView)
  }
  
}


import SwiftUI

struct InfoViewProto2: View {
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

struct ProfileViewProto2: View {
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



#if DEBUG
import SwiftUI
struct UIViewControllerPreview<InfoVCTest: UIViewController>: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: InfoVCTest, context: Context) {
    
  }
  
  let viewController: InfoVCTest
  
  init(_ builder: @escaping () -> InfoVCTest) {
    viewController = builder()
  }
  
    // MARK: - UIViewControllerRepresentable
  func makeUIViewController(context: Context) -> InfoVCTest {
    viewController
  }
}
#endif

struct TestPreviews_Previews: PreviewProvider {
  static var previews: some View {
    UIViewControllerPreview {
      let vc = InfoVCTest()
      return vc
    }
  }
}
