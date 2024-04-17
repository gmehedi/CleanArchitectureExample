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
    let total: Int32?
    let skip: Int32?
    let limit: Int32?
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

//struct ImageURLDTO: Codable {
//    let imageURL: String?
//}


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

extension ProductResponseDTO {
    
    func toEntity(in context: NSManagedObjectContext) -> ProductResponseEntity {
        let entity: ProductResponseEntity = .init(context: context)
        entity.limit = Int32(limit ?? 0)
        entity.total = Int32(total ?? 0)
        entity.skip = Int32(skip ?? 0)
       
        self.products?.forEach {
            entity.addToProductResponse($0.toEntity(context: context))
        }
        return entity
    }
}

extension ProductItemDTO {
    
    func toDomain() -> ProductItem {

        let imageURls = self.images?.map({$0.toDomain()}) ?? []
        
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
                     images: imageURls)
    }
    
    
    func toEntity(context: NSManagedObjectContext) -> ProductResponseItemEntity {
        
        let entity: ProductResponseItemEntity = .init(context: context)

        entity.id = Int32(self.id ?? 0)
        entity.createAt = self.getDate()
        entity.title = self.title ?? ""
        entity.brand = self.brand ?? ""
        entity.descrip = self.description ?? ""
        entity.price = Double(self.price ?? 0)
        entity.discountPrice = self.discountPercentage ?? 0.0
        entity.thumb = self.thumbnail ?? ""
        
        self.images?.forEach {
            entity.addToImagesRelation($0.toEntity(context: context))
        }
        return entity
    }
    
    public func getDate() -> String {
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
        return date
    }
}

extension String {
    
    func toDomain() -> String {
        return self
    }
    
    func toEntity(context: NSManagedObjectContext) -> ImagesEntity {
        let entity: ImagesEntity = .init(context: context)
        entity.image = self
        return entity
    }
}
