//
//  Model.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import Foundation

protocol ModelDelegate {
  func videosFetched(_ videos: [Video], type: ListingViewController.Section)
}

final class Model {
  
  var delegate: ModelDelegate?
  
  func getVideos(from url: String, for type: ListingViewController.Section) {
    //Constants.API_URL was the url previously 
    guard let url = URL(string: url) else { return }
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
          self.delegate?.videosFetched(videos, type: type)
        }
      } catch {
        print("\(error)")
      }
    }
  }
}

