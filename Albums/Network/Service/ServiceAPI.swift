//
//  ServiceAPI.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import Foundation
import RxSwift
import RxCocoa
// MARK: - UsersAPIProtocol

protocol UsersAPIProtocol {
    
    func getUser(completion: @escaping (Result<UserModel?, Error>) -> Void)
    
    
    func getAlbums(userID: Int, completion: @escaping (Result<[AlbumsModel]?, Error>) -> Void)
    
    func getSelectedAlbum(albumID: Int, completion: @escaping (Result<[photo]?, Error>) -> Void)
    
}

//MARK: - Requests
class ServiceAPI: UsersAPIProtocol, BaseAPI {
    
    typealias router = Service
    
    //MARK: - User Requests
    func getUser(completion: @escaping (Result<UserModel?, Error>) -> Void) {
        fetchData(target: .getUser, onComplete: completion)
    }
    
    //MARK: - AlbumsRequests
    func getAlbums(userID: Int, completion: @escaping (Result<[AlbumsModel]?, Error>) -> Void) {
        fetchData(target: .getAlbums(userID: userID), onComplete: completion)

    }
    
    //MARK: - Selected Album Requests
    func getSelectedAlbum(albumID: Int, completion: @escaping (Result<[photo]?, Error>) -> Void) {
        self.fetchData(target: .getSelectedAlbum(AlbumID: albumID), onComplete: completion)
    }
}
