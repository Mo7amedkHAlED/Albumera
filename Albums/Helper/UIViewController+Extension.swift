////
////  UIViewController+Extension.swift
////  Albums
////
////  Created by Mohamed Khaled on 02/03/2023.
////
//
//import UIKit
//
//extension UIViewController {
//    // MARK: - Show Indicator Method
//    func showIndicator(withTitle title: String, and description: String) {
//           let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
//        indicator.label.text = title
//        indicator.isUserInteractionEnabled = false
//        indicator.detailsLabel.text = description
//        indicator.show(animated: true)
//        self.view.isUserInteractionEnabled = false
//    }
//    // MARK: - Hidden Indicator Method
//    func hideIndicator() {
//        MBProgressHUD.hide(for: self.view, animated: true)
//        self.view.isUserInteractionEnabled = true
//    }
//    // MARK: -  Show Alert With Image Method
//    func showAlertWithImage(withTitle: String, andMessage message: String, andImage image: String, completion: (() -> Void)? = nil) {
//
//        let alert = MyAlertViewController( title: withTitle, message: message,
//            imageName: image)
//
//        let okButton = CleanyAlertAction(title: "حسنا", style: .default) { (_) in
//                    (completion ?? {})()
//        }
//        alert.addAction(okButton)
//
//        present(alert, animated: true, completion: nil)
//    }
//}
