//
//  UIViewController+Extension.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/30.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, doneTitle: String, cancelTitle: String, preferredStyle: UIAlertController.Style, complationHandler: @escaping (Bool)->Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { action in
            complationHandler(false)
        }))

        alert.addAction(UIAlertAction(title: doneTitle, style: .default, handler: { action in
            complationHandler(true)
        }))

        // 🙋 present it with this vc since it's on top
        self.present(alert, animated: true)
    }
    
    
    func showAlertWithSingleAction(title: String, message: String, doneTitle: String, preferredStyle: UIAlertController.Style, complationHandler: @escaping (Bool)->Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alert.addAction(UIAlertAction(title: doneTitle, style: .default, handler: { action in
            complationHandler(true)
        }))

        // 🙋 present it with this vc since it's on top
        self.present(alert, animated: true)
    }
    
    
}
