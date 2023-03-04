//
//  ViewController.swift
//  Albums
//
//  Created by Mohamed Khaled on 02/03/2023.
//

import RxSwift
import RxCocoa
import UIKit


class ProfileVC: UIViewController {
    static let ID = String(describing: ProfileVC.self)
    
    // MARK: -  @IBOutlet
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var albumsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: -  Properties
    let profileViewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToLoading()
        getUserData()
        registerTableView()
        subscribeToBranchSelection()
        subscribeToResponse()
    }
    // MARK: - Configure Table View
    func registerTableView() {
        albumsTableView.register(UINib(nibName: MyAlbumsTableViewCell.ID, bundle: nil), forCellReuseIdentifier: MyAlbumsTableViewCell.ID)
    }
    
    // MARK: - Binding Table View Cell with Model Data
    func subscribeToResponse() {
        self.profileViewModel.albumsModelObservable
            .bind(to: self.albumsTableView
                .rx
                .items(cellIdentifier:MyAlbumsTableViewCell.ID ,
                       cellType: MyAlbumsTableViewCell.self)) { row, data, cell in
                cell.configureCell(data)
            }.disposed(by: disposeBag)
    }
    // MARK: - Method to show & hidden loader
    func subscribeToLoading() {
        profileViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidesWhenStopped = true
            }
        }).disposed(by: disposeBag)
    }
    // MARK: - Create Method To Know Selection Cell
    func subscribeToBranchSelection() {
        albumsTableView
            .rx
            .modelSelected(AlbumsModel.self)
            .subscribe(onNext: { [weak self ] model in
                self?.showAlbums(model.id, title: model.title)
        }).disposed(by: disposeBag)
    }
    // MARK: - To Navegite to anther View Controller
    func showAlbums(_ id : Int, title: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: PhotoListVC.ID) as! PhotoListVC
        vc.photesViewModel.albumTitle = title
        vc.photesViewModel.albumID = id
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Get User Data & Albums List From Api
    func getUserData() {
        profileViewModel.fetchUserData()
        profileViewModel.userModelObservable.subscribe(on: MainScheduler.instance).subscribe(onNext: {[weak self] model in
            self?.userName.text = model.name
            guard let address = model.address else { return }
            self?.userLocation.text = "\(address.street ?? "") \(address.suite ?? "") \(address.city ?? "") \(address.zipcode ?? "")"
        }).disposed(by: disposeBag)
    }
}


