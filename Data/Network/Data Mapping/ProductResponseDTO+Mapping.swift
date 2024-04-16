//
//  ProductsDTO+Mapping.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation
import CoreData

// MARK: - Products
//struct ProductsResponseDTO: Codable {
//    let products: ProductResponseDTO?
//}


struct ProductResponseDTO: Codable {
    let total: Int?
    let skip: Int?
    let limit: Int?
    let products: [ProductItemDTO]?
}

// MARK: - Product
struct ProductItemDTO: Codable {
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
    
}


//extension ProductsResponseDTO {
//    
//    func toDomain() -> ProductsResponse {
//        
//        return .init(products: self.products!.toDomain())
//    }
//    
//}

extension ProductResponseDTO {
    
    func toDomain() -> ProductResponse {
        return .init(total: self.total ?? 0, skip: self.skip ?? 0, limit: self.limit ?? 0, products: self.products?.map({$0.toDomain()}) ?? [] )
    }
}

extension ProductItemDTO {
    
    func toDomain() -> ProductItem {

        return .init(id: Int32(self.id ?? 0), 
                     title: self.title ?? "",
                     description: self.description ?? "",
                     price: Int32(self.price ?? 0),
                     discountPercentage: self.discountPercentage ?? 0.0,
                     rating: self.rating ?? 1.0,
                     stock: self.stock ?? 1,
                     brand: self.brand ?? "",
                     category: self.category ?? "",
                     thumbnail: self.thumbnail ?? "",
                     images: self.images ?? [])
    }
    
    func toEntity(context: NSManagedObjectContext) -> ProductResponseEntity {
        
        let entity: ProductResponseEntity = .init(context: context)

        entity.id = Int32(self.id ?? 0)
        entity.createAt = self.getDate()
        entity.title = self.title ?? ""
        entity.brand = self.brand ?? ""
        entity.descrip = self.description ?? ""
        entity.price = Double(self.price ?? 0)
        entity.discountPrice = self.discountPercentage ?? 0.0
        entity.thumb = self.thumbnail ?? ""
       // entity.productsToimages = NSSet(object: self.images)
        
        return entity
    }
    
    public func getDate() -> String {
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
        return date
    }
}


