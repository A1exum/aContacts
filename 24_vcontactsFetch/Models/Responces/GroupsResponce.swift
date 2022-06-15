//
//  GroupsResponse.swift
//  ios-course-l21
//
//  Created by Alex Fount on 02.06.2022.
//

import Foundation

// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let response: GroupItems
}

// MARK: - Response
struct GroupItems: Codable {
    let count: Int
    let items: [GroupModel]
}

// MARK: - Item
struct GroupModel: Codable {
    let id: Int?
    let itemDescription: String?
    let isClosed, isAdvertiser, verified: Int?
    let type: String?
    let membersCount, isMember: Int?
    let photo50, photo200: String?
    let isAdmin: Int?
    let photo100: String?
    let name, screenName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemDescription = "description"
        case isClosed = "is_closed"
        case isAdvertiser = "is_advertiser"
        case verified, type
        case membersCount = "members_count"
        case isMember = "is_member"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case isAdmin = "is_admin"
        case photo100 = "photo_100"
        case name
        case screenName = "screen_name"
    }
}
