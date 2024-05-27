//
//  SearchProductsViewController.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 15/5/24.
//

import UIKit

class SearchProductsViewController: UIViewController, Alertable {

    var viewModel: SearchProductsViewModel!
    
    @IBOutlet weak var searchView: UISearchBar!
    var currQuery = "iphone"
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    var coordinator: SearchProductsFlowCoordinator?
    
    static func create(with viewModel: SearchProductsViewModel) -> SearchProductsViewController {
        let fetchProductVC = SearchProductsViewController(nibName: "SearchProductsViewController", bundle: nil)
        fetchProductVC.viewModel = viewModel
        return fetchProductVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupCollectionView()
        
        self.setupBindings()
        // Do any additional setup after loading the view.
        self.viewModel.searchProducts(with: self.currQuery)
        self.searchView.delegate = self
        
    }

    @IBAction func tappedOnBackButton(_ sender: Any) {
        self.coordinator?.dismissVC()
    }
    
}


extension SearchProductsViewController {
    
    fileprivate func setupBindings() {
        
        self.viewModel.items.observe(on: self, observerBlock: { [weak self] productItems in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
            
        })
        
        self.viewModel.error.observe(on: self, observerBlock: { [weak self] error in
            
            guard let self = self, let error = error else {
                return
            }
            
            DispatchQueue.main.async {
                self.handleFetchError(error: error)
            }
        })
    }
}


//MARK: - Action and Show Fetching Data

extension SearchProductsViewController {
    
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
extension SearchProductsViewController {
    
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
extension SearchProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("Countt  ", self.categories.count)
        return (self.viewModel.items.value?.count ?? 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.row == (self.viewModel.items.value?.count ?? 0) - 1 {
            self.viewModel.didLoadNextPage(with: self.currQuery)
        }
        
        if let cell = self.productsCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.id, for: indexPath) as? ProductCollectionViewCell {
            
            cell.titleLabel.text = self.viewModel.items.value?[indexPath.item].title
            cell.indexLabel.text = String(self.viewModel.items.value?[indexPath.item].id ?? 0)
            
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

extension SearchProductsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.currQuery = text
            debugPrint("New Query  ", text)
            self.viewModel.searchNewProducts(with: self.currQuery)
            self.searchView.resignFirstResponder()
        }
    }
}
