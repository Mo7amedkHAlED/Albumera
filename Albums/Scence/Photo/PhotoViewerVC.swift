//
//  PhotoViewController.swift
//  Albums
//
//  Created by Mohamed Khaled on 04/03/2023.
//

import UIKit

class PhotoViewerVC: UIViewController {
    static let ID = String(describing: PhotoViewerVC.self)
    // MARK: - @IBOutlet
    @IBOutlet weak var imageSelected: UIImageView!
    // MARK: - Properties
    var url : String?
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        imageSelected.loadImage(urlString: url ?? "")
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchHandler(_:)))
        imageSelected.isUserInteractionEnabled = true // enable user interaction
        imageSelected.addGestureRecognizer(pinch) // adding the gesture
    }
    @objc func pinchHandler(_ sender:UIPinchGestureRecognizer){
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view != imageSelected {
                navigationController?.popViewController(animated: true)
                }
        }
            
    }

}
