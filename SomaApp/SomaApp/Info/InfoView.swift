//
//  InfoView.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/11/23.
//
//TODO: Build out info view

import SwiftUI

struct InfoView: View {
    var body: some View {
      ZStack {
        CardView(title: "Title", subtitle: "Subtitle")
      }
    }
}

struct CardView: View {
  var title: String
  var subtitle: String
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20)
        .frame(width: 300, height: 200)
        .shadow(color: Color.label,radius: 10)
      VStack(alignment: .leading) {
        HStack {
          Text(title)
            .font(.title)
          Spacer()
          Ribbon()
            .frame(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.0009)

        }
        .padding()
        
        Divider()
        
        HStack {
          Text(subtitle)
            .font(.subheadline)
          Spacer()
        }
        .padding()
      }
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(Color.secondarySystemBackground)
      )
      
    .frame(width: 300, height: 200)
    }
    
  }
}

struct Ribbon: View {
  var height: CGFloat = 60
  var width: CGFloat = 20
  
  var body: some View {
    Path { path in
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: width, y: 0))
      path.addLine(to: CGPoint(x: width, y: height))
      path.addLine(to: CGPoint(x: width*0.5, y: height*0.9))
      path.addLine(to: CGPoint(x: 0, y: height))
      path.closeSubpath()
    }
    .fill(LinearGradient(gradient: .init(colors: [Color.systemRed, Color.clear]), startPoint: .top, endPoint: .bottom))
    .rotationEffect(.degrees(0))
    .offset(x: -20, y: -15)
  }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
