//
//  Video.swift
//  SomaApp
//
//  Created by Michael Brockman on 1/21/23.
//

import Foundation

struct Video: Decodable, Hashable, Identifiable {
  let id = UUID().uuidString
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: Video, rhs: Video) -> Bool {
    lhs.id == rhs.id
  }
  
  var videoId: String
  var title: String
  var description: String
  var thumbnail: String
  var published: Date
  var section: String
  
  enum CodingKeys: String, CodingKey {
    // containers
    case snippet
    case thumbnails
    case high
    case resourceId
    
    case videoId
    case title
    case description
    case thumbnail = "url"
    case published = "publishedAt"
    case playlistId
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
    self.title = try snippetContainer.decode(String.self, forKey: .title)
    self.description = try snippetContainer.decode(String.self, forKey: .description)
    self.published = try snippetContainer.decode(Date.self, forKey: .published)
    
    let thumbnailsContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
    self.section = try snippetContainer.decode(String.self, forKey: .playlistId)
    
    let highContainer = try thumbnailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
    self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)

    let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
    self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
  }
  
}
