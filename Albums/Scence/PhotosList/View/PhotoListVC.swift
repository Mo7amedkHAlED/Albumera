//
//  PhotesViewController.swift
//  Albums
//
//  Created by Mohamed Khaled on 03/03/2023.
//

import RxSwift
import RxCocoa
import UIKit

class PhotoListVC: UIViewController {
    static let ID = String(describing: PhotoListVC.self)
    // MARK: - @IBOutlet
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties
    let photesViewModel = PhotoListViewModel()
    private let disposeBag = DisposeBag()
    private let searchController = UISearchController()
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        custmizeNavController()
        registerCollectionView()
        getPhotosData()
        subscribeToBranchSelection()
        subscribeToLoading()
        subscribeToResponse()
        searchControllerSetup()
        photosCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    // MARK: - Custmize Navigation Controller
    func custmizeNavController(){
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = photesViewModel.albumTitle
    }
    // MARK: - Search Controller SetUp
    func searchControllerSetup() {
        navigationItem.searchController = searchController
        searchController
            .searchBar
            .searchTextField
            .rx.text.orEmpty
            .bind(to: photesViewModel.searchTextBehavior)
            .disposed(by: disposeBag)
    }
    // MARK: - Configure CollectionView
    func registerCollectionView() {
        photosCollectionView.register(UINib(nibName: PhotosCollectionViewCell.ID, bundle: nil), forCellWithReuseIdentifier: PhotosCollectionViewCell.ID)
        
    }
    // MARK: - Binding Collection View Cell With Model Data
    func subscribeToResponse() {
        self.photesViewModel.photosModelFiltered()
            .bind(to: photosCollectionView
                .rx
                .items(cellIdentifier: PhotosCollectionViewCell.ID,
                       cellType: PhotosCollectionViewCell.self)) { row, data, cell in
                cell.configureCell(data)
            }.disposed(by: disposeBag)
        // MARK: - Create Not Found Image If No Data
        let emptyView = UIImageView()
        emptyView.contentMode = .scaleAspectFit
        emptyView.image = UIImage(named: "result")
        photesViewModel.photosModelFiltered()
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] photos in
                self?.photosCollectionView.backgroundView = photos.isEmpty ? emptyView:nil
        }).disposed(by: disposeBag)
    }
    // MARK: - Create Method To Know Selection Cell
    func subscribeToBranchSelection() {
        photosCollectionView
            .rx
            .modelSelected(photo.self)
            .subscribe(onNext: { [weak self ] model in
                self?.showPhoto(model.url)
        }).disposed(by: disposeBag)
    }
    // MARK: - Method to show & hidden loader
    func subscribeToLoading() {
        photesViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidesWhenStopped = true
            }
        }).disposed(by: disposeBag)
    }
    // MARK: - To Navegite to anther View Controller
    func showPhoto(_ url : String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: PhotoViewerVC.ID) as! PhotoViewerVC
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Get User Data List From Api
    func getPhotosData() {
        photesViewModel.fetchPhotosData()
    }
}
// MARK: - Extension Photes View Controller To Implement FlowLayout
extension PhotoListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: (width / 3)  , height: 144)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
