//
//  Service.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import Foundation
import Moya

enum Service {
    case getUser
    case getAlbums(userID: Int)
    case getSelectedAlbum(AlbumID: Int)
}
extension Service: BaseEndpoint {
    
    // MARK: - This is the path of each operation that will be appended to our base URL.
    var path: String {
        let randomUserID = Int.random(in: 1...6)
        switch self {
        case .getUser:
            return "users/\(randomUserID)"
        case .getAlbums:
            return "albums"
        case .getSelectedAlbum:
            return "photos"

        }
    }
    
    // MARK: - Here we specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .getUser, .getAlbums:
            return .get
        case .getSelectedAlbum(_):
            return .get
        }
    }
    
    // MARK: - Here we specify body parameters, objects, files etc.
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        case .getAlbums(let userID):
            return .requestParameters(parameters: [Constants.Parameter.userID: userID], encoding: URLEncoding.default)
        case .getSelectedAlbum(let albumID):
            return .requestParameters(parameters: [Constants.Parameter.albumID: albumID], encoding: URLEncoding.default)
        }
    }
    
    // MARK: -  These are the headers that our service requires.
    var headers: [String: String]? {
        return [Constants.Header.contentType : Constants.ContentType.json]
    }
}
