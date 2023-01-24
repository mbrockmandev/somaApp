//
//  ProfileView.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/24/23.
//

import SwiftUI

struct ProfileView: View {
  var profile: String
  var name: String
  var locations: [String]
  
    var body: some View {
      VStack {
        ZStack {
          RoundedRectangle(cornerRadius: 5)
            .padding(.horizontal)
            .foregroundColor(.white)
            .border(.thinMaterial, width: 2)
          
          Image(profile)
            .resizable()
            .scaledToFill()
          
        }
        .frame(maxWidth: 300, maxHeight: 240)
        
        Spacer()
          .frame(height: 20)
        VStack(spacing: 6) {
          Text(name)
            .font(.title)
          .bold()
        
          .frame(height: 20)
        Spacer()
            .frame(height: 20)
          ForEach(locations, id:\.self) {
            Text($0)
          }
        }
      }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: "matt_thumb", name: "Matt Strack", locations: ["Dayton, OH", "West Chester, OH", "Oxford, OH"])
    }
}
