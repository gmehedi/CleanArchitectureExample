//
//  QueryResponseEntity+Mapping.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/13.
//

import Foundation
import CoreData

extension ProductResponseEntity {
    
    func toDTO() -> ProductResponseDTO {
        
        return .init(total: self.total, skip: self.skip , limit: self.limit , products: self.productResponse?.array.map({ ($0 as! ProductResponseItemEntity).toDTO() }))
    }
}

extension ProductResponseItemEntity {
    
    func toDomain() -> ProductItem {
       
        let images =  self.imagesRelation?.array.map({($0 as! String)}) ?? []
      
        return .init(id: id, title: title!, description: description, price: Double(price), discountPercentage: discountPrice, rating: 5.0, stock: 100, brand: brand ?? "Apple", category: "", thumbnail: thumb!, images: images)
    }
}


extension ProductResponseItemEntity {
    
    func toDTO() -> ProductItemDTO {
       // vcbvcbcvbcvbcvbvc
        let images =  self.imagesRelation?.array.map({($0 as! ImagesEntity)}) ?? []
        
        return .init(id: Int(id), title: title!, description: description, price: price, discountPercentage: discountPrice, rating: 5.0, stock: 100, brand: brand ?? "Apple", category: "", thumbnail: thumb!, images: images.map({$0.image ?? ""}))
    }
    
}

extension ProductsRequestDTO {
    
    func toEntity(in context: NSManagedObjectContext) -> ProductsRequestEntity {
        let entity: ProductsRequestEntity = .init(context: context)
        entity.query = q
        entity.limit = Int32(limit)
        entity.skip = Int32(skip)
        return entity
    }
}


//extension ProductsResponse {
//
//    func toEntity(in context: NSManagedObjectContext) -> ProductResponseEntity {
//
//        let productEntity: ProductResponseEntity = .init(context: context)
//        
//        self.products.products.forEach({ product in
//
//            var entity: ProductResponseEntity = .init(context: context)
//            
//            entity.id = product.id
//            entity.createAt = self.getDate()
//            entity.title = product.title
//            entity.brand = product.brand
//            entity.descrip = product.description
//            entity.price = Double(product.price)
//            entity.discountPrice = product.discountPercentage
//            entity.thumb = product.thumbnail
//            entity.productImages = NSSet(object: product.images)
//        })
//        
//        return productEntity
//    }
//
//    public func getDate() -> String {
//        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
//        return date
//    }
//
//}

//extension ProductsResponseDTO {
//
//    func toEntity(in context: NSManagedObjectContext) -> ProductResponseEntity {
//
//        let productEntity: ProductResponseEntity = .init(context: context)
//        
//        self.products?.products?.forEach({ product in
//
//            var entity: ProductResponseEntity = .init(context: context)
//            
//            entity.id = Int32(product.id ?? 0)
//            entity.createAt = self.getDate()
//            entity.title = product.title ?? ""
//            entity.brand = product.brand ?? ""
//            entity.descrip = product.description ?? ""
//            entity.price = Double(product.price ?? Int(0.0))
//            entity.discountPrice = product.discountPercentage ?? 0.0
//            entity.thumb = product.thumbnail ?? ""
//            entity.productImages = NSSet(object: product.images ?? [])
//        })
//        
//        return productEntity
//    }
//
//    public func getDate() -> String {
//        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
//        return date
//    }
//
//}
