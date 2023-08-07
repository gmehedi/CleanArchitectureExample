//
//  SplashViewController.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/09.
//

import UIKit



class SplashViewController: UIViewController {

    weak var coordinator: SplashFlowCoordinator?
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    static func create() -> SplashViewController {
        let splashVC = SplashViewController(nibName: "SplashViewController", bundle: nil)
        return splashVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.goToHomeVC()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

extension SplashViewController {
    
    private func goToHomeVC() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.appDelegate?.setHomeCoorditanor()
        })
    }
    
}
