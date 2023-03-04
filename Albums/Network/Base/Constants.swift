//
//  Constants.swift
//  Albums
//
//  Created by Mohamed Khaled on 05/03/2023.
//

import Foundation

struct Constants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    static let genericeError = "Something went wrong, please try again later"
    
    enum Parameter {
        static let userID = "userId"
        static let albumID = "albumId"
    }
    
    enum Header {
        static let contentType = "Content-Type"
    }

    enum ContentType {
        static let json = "application/json"
    }
}
