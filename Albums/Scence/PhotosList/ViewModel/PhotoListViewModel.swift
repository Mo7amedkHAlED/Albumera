//
//  PhotoListViewModel.swift
//  Albums
//
//  Created by Mohamed Khaled on 03/03/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class PhotoListViewModel {
    // MARK: - Properties
    var albumID: Int?
    var albumTitle: String?
    let searchTextBehavior: BehaviorRelay<String> = .init(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var photosModelSubject = PublishSubject<[photo]>()
    
    // MARK:  Fetch Photos Data From Api
    func fetchPhotosData() {
        loadingBehavior.accept(true)
        api.getSelectedAlbum(albumID: albumID!) { [weak self] (result) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result {
            case .success(let photos):
                guard let result = photos else { return }
                self.photosModelSubject.onNext(result)
                print(result)
            case .failure(let error):
                self.loadingBehavior.accept(false)
                print(error.localizedDescription)
            }
        }
    }
    
    func photosModelFiltered() -> Observable<[photo]> {
        // last value search // all Value of Model
      return Observable.combineLatest(searchTextBehavior.asObservable(), photosModelSubject)
            .map { (search , photos) in
                let filteredPhotos =  search == "" ?  photos:photos.filter({$0.title.lowercased().contains(search.lowercased())})
                return filteredPhotos

            }
    }
    
}
