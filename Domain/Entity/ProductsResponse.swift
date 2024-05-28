//
//  ProductsEntity.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation

// MARK: - Product Response
struct ProductResponse: Equatable {
    let total: Int32
    let skip: Int32
    let limit: Int32
    let products: [ProductItem]
}

// MARK: - Product Item
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
        //Note: `description` and `discount` are not included here, so they will be ignored.
    }
    
    static func getDefaultData(with id: Int32) -> ProductItem {
        
        return .init(id: id,
                     title: "Mehedi",
                     description: "Mehedi",
                     price: 100.0,
                     discountPercentage: 1.0,
                     rating: 5.0,
                     stock: 100,
                     brand: "Mehedi",
                     category: "Mehedi",
                     thumbnail: "Mehedi",
                     images: ["Mehedi"])
    }
    
    func toDictionary() -> [String: AnyObject] {
        
        var asDictionary: [String: AnyObject] {
            let mirror = Mirror(reflecting: self)
            let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map { (label: String?, value: Any?) -> (String, AnyObject)? in
                guard let label = label else { return nil }
                if let valueAsObject = value as? AnyObject {
                    return (label, valueAsObject)
                }
                // If the value is not an AnyObject, it can't be added to the dictionary
                return nil
            }.compactMap { $0 })
            return dict
        }
        
        return asDictionary
    }

}


