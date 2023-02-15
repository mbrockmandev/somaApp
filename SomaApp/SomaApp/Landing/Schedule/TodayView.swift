//
//  TodayView.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/14/23.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
      
      VStack {
        Spacer()
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .frame(minWidth: 300, maxWidth: .infinity, minHeight: 80, maxHeight: 180)
            .foregroundColor(.secondarySystemBackground)
          VStack {
            Text("4:30-5:00PM")
            Text("Little Porcupines")
            Text("Ages 3-6")
          }
          .bold()
        }
        Spacer()
      }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
