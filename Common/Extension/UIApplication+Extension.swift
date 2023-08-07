//
//  UIApplication+Extension.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/08/03.
//

import Foundation
import UIKit

extension UIApplication {
    static var topSafeAreaHeight: CGFloat {
        var topSafeAreaHeight: CGFloat = 0
         if #available(iOS 11.0, *) {
               let window = UIApplication.shared.windows[0]
               let safeFrame = window.safeAreaLayoutGuide.layoutFrame
               topSafeAreaHeight = safeFrame.minY
             }
        return topSafeAreaHeight
    }
}
