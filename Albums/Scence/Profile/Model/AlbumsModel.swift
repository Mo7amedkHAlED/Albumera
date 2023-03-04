//
//  Albums.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import Foundation

// MARK: - AlbumsModel
struct AlbumsModel: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
