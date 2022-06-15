//
//  File.swift
//  ios-course-l21
//
//  Created by Alex Fount on 5.06.22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photosResponse = try? newJSONDecoder().decode(PhotosResponse.self, from: jsonData)

import Foundation

// MARK: - PhotosResponse
struct PhotosResponse: Codable {
    let response: PhotoItem
}

// MARK: - Response
struct PhotoItem: Codable {
    let count: Int
    let items: [PhotoModel]
}

// MARK: - Item
struct PhotoModel: Codable {
    let albumID, date, id, ownerID: Int
    let sizes: [Size]?
    let text: String?
    let hasTags: Bool
    let likes: Likes
    let reposts: Reposts
    
    
    var presentPhotos: (minPhoto: String, maxPhoto: String) {
        if let sortedPhotos = sizes?.filter{$0.height > 190 && $0.height < 1750}.sorted(by: {$0.height<$1.height})
        {
            let photos = (sortedPhotos[0].url, sortedPhotos[sortedPhotos.count - 1].url)
        return (photos)
        }
        return ("","")
    }
    
    var averagePhoto: String {
        if let count = self.sizes?.count, count >= 1{
            if count == 1 {
                return self.sizes?[0].url ?? ""
            }
            let averageIndex = Int((Double(count)/2).rounded(.up))
            let photoUrl = self.sizes?[averageIndex].url ?? ""
            return photoUrl
        }
        return ""
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case hasTags = "has_tags"
        case likes, reposts
    }
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
}
