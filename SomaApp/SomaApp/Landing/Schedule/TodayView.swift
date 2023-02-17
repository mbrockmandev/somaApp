//
//  TodayView.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/14/23.
//

import SwiftUI

struct TodayView: View {
  let classes = Class.DaytonClasses
  let location = UserDefaults.standard.string(forKey: "userLocation")!
//  let location = "dayton"
  
    var body: some View {
      VStack {
        Text(Date().getFormattedDate(format: "EEEE") + " Classes @\(location):")
          .font(.title)
        List {
          ForEach(classes, id:\.self) { cls in
            ClassView(theClass: cls)
          }
        }
      }
    }
}

struct TodayView_Previews: PreviewProvider {
  
    static var previews: some View {
        TodayView()
    }
}

struct ClassView: View {
  let theClass: Class
  var body: some View {
    
    ZStack {
      RoundedRectangle(cornerRadius: 20)
        .foregroundColor(.mint).opacity(0.1)
        .shadow(color: Color.secondaryLabel, radius: 10)
      VStack(alignment: .center) {
          Text(theClass.title)
          .font(.title)
          .bold()
        .padding()
        
        Divider()
        
        HStack {
          VStack {
            Text(theClass.time)
              .font(.subheadline)
              .bold()
            Text("Ages: " + theClass.ageGroup).fontWeight(.medium)
          }
        }
        .padding()
      }
      .background(
        RoundedRectangle(cornerRadius: 15)
          .fill(Color.tertiarySystemBackground)
      )
      .frame(width: 285)
    }
    
  }
}
