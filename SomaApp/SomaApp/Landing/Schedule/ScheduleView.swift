//
//  ScheduleView.swift
//  SomaApp
//
//  Created by Michael Brockman on 2/11/23.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
      Text("Need to put some schedules here!")
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}


struct FileItem: Hashable, Identifiable, CustomStringConvertible {
  var id: Self { self }
  var name: String
  var children: [FileItem]? = nil
  var description: String {
    switch children {
    case nil:
      return "📄 \(name)"
    case .some(let children):
      return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
    }
  }
}


