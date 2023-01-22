//
//  Model.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import Foundation

protocol ModelDelegate {
  func videosFetched(_ videos: [Video])
}

final class Model {
  
  var delegate: ModelDelegate?
  
  func getVideos() {
    
    guard let url = URL(string: Constants.API_URL) else { return }
    let session = URLSession.shared
    Task {
      let (data, response) = try await session.data(from: url)
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      do {
        let decodedData = try decoder.decode(Response.self, from: data)
        guard let videos = decodedData.items else { return }
        Task { @MainActor in
          self.delegate?.videosFetched(videos)          
        }
      } catch {
        print("\(error)")
      }
    }
  }
}


