//
//  Model.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import Foundation

protocol ModelDelegate {
  func videosFetched(_ videos: [Video], type: Model.VideoType)
}

final class Model {
  var delegate: ModelDelegate?
  
  struct Section: Hashable {
    let uuid: String
    let title: String
    
    public func hash(into hasher: inout Hasher) {
      hasher.combine(self.uuid)
      hasher.combine(self.title)
    }
    
    public static func == (lhs: Section, rhs: Section) -> Bool {
      return lhs.uuid == rhs.uuid && lhs.title == rhs.title
    }
  }
  
  enum Subset {
    case ground
    case standing
  }
  
  enum VideoType {
    case `guard`, sideMount, mount, backMount, strike, hold, strangle, weapon
  }
  
    // ground videos
  var guardVideos = [Video]()
  var sideMountVideos = [Video]()
  var mountVideos = [Video]()
  var backMountVideos = [Video]()
    // standing videos
  var strikeVideos = [Video]()
  var holdVideos = [Video]()
  var strangleVideos = [Video]()
  var weaponVideos = [Video]()
  
  var whichMonth: Int!

  var currentSubset: Subset = .ground
  
  // MARK: Methods

  func getVideos(from url: String, for type: VideoType) {
  
    guard let url = URL(string: url) else { return }

    let session = URLSession.shared
    Task {
      let (data, response) = try await session.data(from: url)
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return }
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      do {
        let decodedData = try decoder.decode(Response.self, from: data)
        if let videos = decodedData.items {
          self.delegate?.videosFetched(videos, type: type)
        }
      } catch {
        print("\(error)")
      }
    }
  }
  
  func downloadData(for subset: Subset) {
    
    switch subset {
    case .ground:
      getVideos(from: Constants.GUARD_PLAYLIST_URL, for: .guard)
      getVideos(from: Constants.SIDEMOUNT_PLAYLIST_URL, for: .sideMount)
      getVideos(from: Constants.MOUNT_PLAYLIST_URL, for: .mount)
      getVideos(from: Constants.BACKMOUNT_PLAYLIST_URL, for: .backMount)
      
    case .standing:
      getVideos(from: Constants.STRIKE_PLAYLIST_URL, for: .strike)
      getVideos(from: Constants.HOLD_PLAYLIST_URL, for: .hold)
      getVideos(from: Constants.STRANGLE_PLAYLIST_URL, for: .strangle)
      getVideos(from: Constants.WEAPON_PLAYLIST_URL, for: .weapon)
    }
  }
}


