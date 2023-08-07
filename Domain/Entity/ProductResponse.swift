//
//  ProductsEntity.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation

// MARK: - Products
struct ProductResponse: Equatable {
    static func == (lhs: ProductResponse, rhs: ProductResponse) -> Bool {
        return true
    }
    
    let products: [ProductItem]
    let total, skip, limit: Int
}

// MARK: - Product
struct ProductItem: Equatable {
    let id: Int32
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
