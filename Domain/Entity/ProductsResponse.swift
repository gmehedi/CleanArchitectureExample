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
    let total: Int32
    let skip: Int32
    let limit: Int32
    let products: [ProductItem]
}


// MARK: - Product
struct ProductItem: Equatable {
    let id: Int32
    let title, description: String
    let price: Double
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case title
        case description
        case discountPercentage
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case images
        // Note: `description` and `discount` are not included here, so they will be ignored.
    }
}
