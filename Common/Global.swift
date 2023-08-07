//
//  Global.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/25.
//

import UIKit

let loaderView = UIActivityIndicatorView(frame: .zero)

let searchLoaderView = UIActivityIndicatorView(frame: .zero)

func showLoaderOn(view: UIView, loaderSize: CGFloat) {
    
    DispatchQueue.main.async {
        let mini = min(view.bounds.width, view.bounds.height)
        let padding = (mini - loaderSize) * 0.5
        
        loaderView.removeFromSuperview()
        loaderView.frame = view.bounds
        view.addSubview(loaderView)
        
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            loaderView.backgroundColor = .black.withAlphaComponent(0.2)
        })
        
        loaderView.startAnimating()
    }
    
}

func hideLoader() {
    
    DispatchQueue.main.async {
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            loaderView.backgroundColor = .clear.withAlphaComponent(0.2)
        })
        loaderView.stopAnimating()
        loaderView.removeFromSuperview()
    }
}

func showSearchLoaderView(view: UIView, loaderSize: CGFloat) {
    
    DispatchQueue.main.async {
        let mini = min(view.bounds.width, view.bounds.height)
        let padding = (mini - loaderSize) * 0.5
        searchLoaderView.backgroundColor = .clear
        searchLoaderView.removeFromSuperview()
        searchLoaderView.frame = view.bounds
        searchLoaderView.layer.cornerRadius = view.layer.cornerRadius
       
        view.addSubview(searchLoaderView)
        searchLoaderView.startAnimating()
    }
    
}

func hideSearchLoaderView() {
    
    DispatchQueue.main.async {
        searchLoaderView.stopAnimating()
        searchLoaderView.removeFromSuperview()
    }
}
