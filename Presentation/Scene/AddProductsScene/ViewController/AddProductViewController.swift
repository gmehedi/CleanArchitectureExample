//
//  AddProductViewController.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 28/5/24.
//

import UIKit

class AddProductViewController: UIViewController {

    var viewModel: AddProductViewModel!
    var coordinator: AddProductFlowCoordinator?
    
    static func create(with viewModel: AddProductViewModel) -> AddProductViewController {
        let fetchProductVC = AddProductViewController(nibName: "AddProductViewController", bundle: nil)
        fetchProductVC.viewModel = viewModel
        return fetchProductVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedOnAddNewData(_ sender: Any) {
        self.viewModel.addNewProducts(with: 1)
    }
    
    @IBAction func tappedOnBackButton(_ sender: Any) {
        self.coordinator?.dismissVC()
    }

}
