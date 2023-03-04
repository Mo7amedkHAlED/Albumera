//
//  ProfileViewModel.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ProfileViewModel {
    // MARK:  Vars
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var userModelSubject = PublishSubject<UserModel>()
    var userModelObservable: Observable<UserModel> {
        return userModelSubject
    }
    
    private var albumsModelSubject = PublishSubject<[AlbumsModel]>()
    var albumsModelObservable: Observable<[AlbumsModel]> {
        return albumsModelSubject
    }
    
    // MARK:  Fetch User Data From Api
    func fetchUserData() {
        self.loadingBehavior.accept(true)
        api.getUser { [weak self] (result) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result {
            case .success(let user):
                guard let result = user else { return }
//                self.userId = result.id ?? 0
                self.userModelSubject.onNext(result)
                guard let userID = result.id else { return }
                self.fetchAlbumsData(id: userID)
            case .failure(let error):
                self.loadingBehavior.accept(false)
                print(error.localizedDescription)
            }
        }
        
    }
    
    // MARK:  Fetch Albums Data From Api
    func fetchAlbumsData(id: Int) {
        loadingBehavior.accept(true)
        api.getAlbums(userID: id ) { [weak self] (album) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch album {
            case .success(let album):
                guard let albumData = album else { return }
                self.albumsModelSubject.onNext(albumData)
            case .failure(let error):
                self.loadingBehavior.accept(false)
                print(error.localizedDescription)
            }
        }
    }
}

