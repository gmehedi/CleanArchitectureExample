//
//  ProductsDTO+Mapping.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation
import CoreData

// MARK: - Products
struct ProductsResponseDTO: Codable {
    let productResponseDTO: ProductResponseDTO
}

struct ProductResponseDTO: Codable {
    let total: Int
    let skip: Int
    let limit: Int
    let products: [ProductItemDTO]
}

// MARK: - Product
struct ProductItemDTO: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}


extension ProductsResponseDTO {
    
    func toDomain() -> ProductsResponse {
        return .init(products: self.productResponseDTO.toDomain())
    }
    
}

extension ProductResponseDTO {
    
    func toDomain() -> ProductResponse {
        return .init(total: self.total, skip: self.skip, limit: self.limit, products: self.products.map({$0.toDomain()}))
    }
}

extension ProductItemDTO {
    
    func toDomain() -> ProductItem {
        return .init(id: Int32(self.id), title: self.title, description: self.description, price: self.price, discountPercentage: self.discountPercentage, rating: self.rating, stock: self.stock, brand: self.brand, category: self.category, thumbnail: self.thumbnail, images: self.images)
    }
    
    func toEntity(context: NSManagedObjectContext) -> ProductResponseEntity {
        
        let entity: ProductResponseEntity = .init(context: context)

        entity.id = Int32(self.id)
        entity.createAt = self.getDate()
        entity.title = self.title
        entity.brand = self.brand
        entity.descrip = self.description
        entity.price = Double(self.price)
        entity.discountPrice = self.discountPercentage
        entity.thumb = self.thumbnail
       // entity.productsToimages = NSSet(object: self.images)
        
        return entity
    }
    
    public func getDate() -> String {
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
        return date
    }
}


