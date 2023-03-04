//
//  NetworkError.swift
//  Albums
//
//  Created by Mohamed Khaled on 05/03/2023.
//

import Foundation

enum NetworkError: Error {
    case somethingWentWrong
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .somethingWentWrong:
            return "Something went wrong, please try again later"
        }
    }
}
