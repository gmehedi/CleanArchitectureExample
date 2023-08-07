//
//  UIView+UIApplication+Extension.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/09.
//

import Foundation
import UIKit

extension UIView {

    var safeAreaBottom: CGFloat {
         if #available(iOS 11, *) {
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.bottom
            }
         }
         return 0
    }

    var safeAreaTop: CGFloat {
         if #available(iOS 11, *) {
             
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                return window.safeAreaInsets.top
            }
         }
         return 0
    }
    
}

extension UIApplication {
    
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
    
}
