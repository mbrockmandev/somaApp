//
//  Model.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import Foundation

final class Model {
  var url = URL(string: "")
  
  func getVideos() {
    
    // make url object
    guard let url = URL(string: Constants.API_URL) else { return }
    self.url = url
    let session = URLSession.shared
    Task {
      let (data, response) = try await session.data(from: url)
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
      
      do {
        
      } catch {
        print("\(error)")
      }
      
    }
   
  }
}
