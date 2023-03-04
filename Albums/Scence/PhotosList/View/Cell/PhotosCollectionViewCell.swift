//
//  PhotosCollectionViewCell.swift
//  Albums
//
//  Created by Mohamed Khaled on 03/03/2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static let ID = String(describing: PhotosCollectionViewCell.self)
    // MARK: - @IBOutlet
    @IBOutlet weak var albumImage: UIImageView!
    // MARK:   Make Configure Cell
    func configureCell(_ collection: photo) {
        albumImage.loadImage(urlString: collection.url)
    }

}
