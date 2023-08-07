//
//  RootNavigationController.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/09.
//

import Foundation
import UIKit

class RootNavigationController: UINavigationController {
    
    var isStatusbarShouldHide: Bool = true
    
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusbarShouldHide
    }
    
    public func updateStatusBarAppearance(isShouldHide: Bool) {
        self.isStatusbarShouldHide = isShouldHide
        setNeedsStatusBarAppearanceUpdate()
    }
    
}
