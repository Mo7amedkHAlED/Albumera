//
//  photo.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import Foundation
// MARK: - photo
struct photo: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
