  //
  //  ContentView.swift
  //  SomaSwiftUI
  //
  //  Created by Michael Brockman on 1/28/23.
  //

import SwiftUI

struct WelcomeView: View {
  let vm = WelcomeViewModel()
  
  var body: some View {
    ZStack {
      Image("soma_red_black")
      VStack(alignment: .center) {
        ZStack {
          bannerImage
            .frame(height: 280)
            .padding(.horizontal)
        }
        
        
        
        storeView
          .onTapGesture {
            //
          }
          
      }
    }
    
  }
  
  var bannerImage: some View {
    TabView {
      ForEach(vm.images, id:\.self) { image in
        GeometryReader { proxy in
          let minX = proxy.frame(in: .global).minX
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .blur(radius: abs(minX / 120))
            .frame(height: 280)
            .background(RoundedRectangle(cornerRadius: vm.cornerRadius, style: .continuous).background(Color.clear))
        }
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
  
  var storeView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: vm.cornerRadius, style: .continuous)
        .fill(Color.primary.opacity(0.3))
        .frame(width: 120, height: 120)
        
      Text("Store")
        .font(.largeTitle)
        .bold()
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}

