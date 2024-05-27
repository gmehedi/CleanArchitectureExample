//
//  HomeViewController.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/09.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var fullScreenView: UIView!
    @IBOutlet weak var safeAreaView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    var viewModel: HomeViewModel!
    var homeMenuModel: [HomeMenuModel]!
    
    var coordinator: HomeFlowCoordinator?
    
    private var isFirst = true
    var isShowed = false
    
    static func create(with viewModel: HomeViewModel, homeMenuModel: [HomeMenuModel]) -> HomeViewController {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        homeVC.viewModel = viewModel
        homeVC.homeMenuModel = homeMenuModel
        return homeVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.isFirst {
            
            self.isFirst = false
            self.view.layoutIfNeeded()
            self.setupCollectionView()

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}


//MARK: CollectionView
extension HomeViewController {
    
    fileprivate func setupCollectionView() {
        
        self.collectionView.layoutIfNeeded()
        
        self.registerCollectionViewCell()
        self.setCollectionViewFlowLayout()
        self.setCollectionViewDelegate()
        
        UIView.performWithoutAnimation {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Registration nib file and Set Delegate, Datasource
    fileprivate func registerCollectionViewCell() {
        
        let homeNib = UINib(nibName: HomeCollectionViewCell.id, bundle: nil)
        self.collectionView.register(homeNib, forCellWithReuseIdentifier: HomeCollectionViewCell.id)
        
    }
    
    //MARK: Set Collection View Flow Layout
    fileprivate func setCollectionViewFlowLayout() {
        
        if let layoutMenu = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layoutMenu.scrollDirection = .vertical
            layoutMenu.minimumLineSpacing = 16
            layoutMenu.minimumInteritemSpacing = 16
        }
        
        self.collectionView.contentInset = UIEdgeInsets(top: 64, left: 20, bottom: 100, right: 20)
    }
    
    //MARK: Set Collection View Delegate
    fileprivate func setCollectionViewDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

//MARK: CollectionView Data Source and Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("Countt  ", self.categories.count)
        return self.homeMenuModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.id, for: indexPath) as? HomeCollectionViewCell {
            
            cell.titleLabel.text = homeMenuModel[indexPath.item].title
            
            return cell
            
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedAction(action: self.homeMenuModel[indexPath.item].actionType)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let newSize = CGSize(width: collectionView.bounds.width - (2.0 * 8), height: 125.0)
        
        return newSize
    }
    
}

extension HomeViewController {
    
    func selectedAction(action: HomeActionType) {
        
        switch action {
        case .searchProduct:
            self.coordinator?.goToSearchProductsViewController()
            break
        case .getProduct:
            self.coordinator?.goToFetchProductsViewController()
            break
        }
    }
}
