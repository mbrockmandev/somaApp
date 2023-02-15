//
//  ScheduleView.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/11/23.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
      List {
        VStack {
          HStack {
            ZStack {
              RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.systemRed).opacity(0.8)
                .frame(width: 40, height: 40)
              Text("Feb")
                .foregroundColor(.secondarySystemBackground)
                .padding()
                .bold()
            }
            RoundedRectangle(cornerRadius: 5)
              .foregroundColor(.tertiaryLabel)
          }
          RoundedRectangle(cornerRadius: 5)
            .foregroundColor(.tertiaryLabel)
        }
        
      }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

//struct FileItem: Hashable, Identifiable, CustomStringConvertible {
//  var id: Self { self }
//  var name: String
//  var children: [FileItem]? = nil
//  var description: String {
//    switch children {
//    case nil:
//      return "📄 \(name)"
//    case .some(let children):
//      return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
//    }
//  }
//}


