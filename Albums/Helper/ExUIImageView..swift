//
//  ExUIImageView..swift
//  Albums
//
//  Created by Mohamed Khaled on 03/03/2023.
//

import UIKit
import Kingfisher

extension UIImageView{
    func loadImage(urlString:String){
        guard let url = URL(string: urlString) else{return}
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}
