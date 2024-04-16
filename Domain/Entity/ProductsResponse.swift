//
//  ProductsEntity.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation

// MARK: - Products
//struct ProductsResponse: Equatable {
//    static func == (lhs: ProductsResponse, rhs: ProductsResponse) -> Bool {
//        return true
//    }
//    
//    let products: ProductResponse
//}

struct ProductResponse: Equatable {
    let total: Int
    let skip: Int
    let limit: Int
    let products: [ProductItem]
}

// MARK: - Product
struct ProductItem: Equatable {
    let id: Int32
    let title, description: String
    let price: Int32
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
