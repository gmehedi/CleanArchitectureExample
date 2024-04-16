//
//  FetchProductsViewController.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/06.
//

import UIKit

class FetchProductsViewController: UIViewController, Alertable {

    var viewModel: FetchProductsViewModel!
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var coordinator: FetchProductsFlowCoordinator?
    
    var products = [ProductItem]()
    
    
    static func create(with viewModel: FetchProductsViewModel) -> FetchProductsViewController {
        let fetchProductVC = FetchProductsViewController(nibName: "FetchProductsViewController", bundle: nil)
        fetchProductVC.viewModel = viewModel
        return fetchProductVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
        
        self.setupBindings()
        // Do any additional setup after loading the view.
        self.viewModel.fetchProducts()
    }
    
    @IBAction func tappedOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension FetchProductsViewController {
    
    fileprivate func setupBindings() {
        
        self.viewModel.result.observe(on: self, observerBlock: { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success((let productResponse)):
                //debugPrint("APICALL   22222  ")
                DispatchQueue.main.async {
                    self.products = productResponse?.products ?? []
                    self.productsCollectionView.reloadData()
                }
                
            case .failure(let error):
                //       debugPrint("APICALL   33333  ")
                DispatchQueue.main.async {
                    self.handleFetchError(error: error)
                }
                
            case .none:
                
                break
            }
            
        })
        
        self.viewModel.cache.observe(on: self, observerBlock: { [weak self] productResponse in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                if let product = productResponse {
                    self.products = productResponse?.products ?? []
                    self.productsCollectionView.reloadData()
                }
               
            }
        })
    }
}


//MARK: - Action and Show Fetching Data

extension FetchProductsViewController {
    
    private func handleFetchError(error: DataTransferError) {
        
        switch error {
        case .networkFailure:
            self.showNetworkError(description: "No Internet\nPlease check your internet.")
            break
        case .noResponse:
            
            self.showGenericError(description: error.localizedDescription)
            break
        case .parsing:
            
            self.showGenericError(description: error.localizedDescription)
            break
        case .resolvedNetworkFailure(_):
            
            self.showGenericError(description: error.localizedDescription)
            break
        }
        
    }
    
    func showGenericError(description: String) {
        showAlert(message: description)
    }
    
    func showNetworkError(description: String) {
        showAlert(message: description)
    }
}



//MARK: CollectionView
extension FetchProductsViewController {
    
    fileprivate func setupCollectionView() {
        
        self.productsCollectionView.layoutIfNeeded()
        
        self.registerCollectionViewCell()
        self.setCollectionViewFlowLayout()
        self.setCollectionViewDelegate()
        
        UIView.performWithoutAnimation {
            self.productsCollectionView.reloadData()
        }
    }
    
    //MARK: Registration nib file and Set Delegate, Datasource
    fileprivate func registerCollectionViewCell() {
        
        let homeNib = UINib(nibName: ProductCollectionViewCell.id, bundle: nil)
        self.productsCollectionView.register(homeNib, forCellWithReuseIdentifier: ProductCollectionViewCell.id)
        
    }
    
    //MARK: Set Collection View Flow Layout
    fileprivate func setCollectionViewFlowLayout() {
        
        if let layoutMenu = self.productsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layoutMenu.scrollDirection = .vertical
            layoutMenu.minimumLineSpacing = 16
            layoutMenu.minimumInteritemSpacing = 16
        }
        
        self.productsCollectionView.contentInset = UIEdgeInsets(top: 64, left: 20, bottom: 100, right: 20)
    }
    
    //MARK: Set Collection View Delegate
    fileprivate func setCollectionViewDelegate() {
        self.productsCollectionView.delegate = self
        self.productsCollectionView.dataSource = self
    }
    
}

//MARK: CollectionView Data Source and Delegate
extension FetchProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("Countt  ", self.categories.count)
        return self.products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.productsCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.id, for: indexPath) as? ProductCollectionViewCell {
            
            cell.titleLabel.text = self.products[indexPath.item].title
            return cell
            
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let newSize = CGSize(width: collectionView.bounds.width - (2.0 * 8), height: 125.0)
        
        return newSize
    }
    
}
