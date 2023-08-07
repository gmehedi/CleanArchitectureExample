//
//  QueryResponseEntity+Mapping.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/13.
//

import Foundation
import CoreData

extension ProductResponse {

    func toEntity(in context: NSManagedObjectContext) -> ProductEntity {

        let productEntity: ProductEntity = .init(context: context)
        
        self.products.forEach({ product in

            var entity: ProductEntity = .init(context: context)
            
            entity.id = product.id
            entity.createAt = self.getDate()
            entity.title = product.title
            entity.brand = product.brand
            entity.descrip = product.description
            entity.price = Double(product.price)
            entity.discountPrice = product.discountPercentage
            entity.thumb = product.thumbnail
            entity.productsToimages = NSSet(object: product.images)
        })
        
        return productEntity
    }

    public func getDate() -> String {
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
        return date
    }

}

extension ProductResponseDTO {

    func toEntity(in context: NSManagedObjectContext) -> ProductEntity {

        let productEntity: ProductEntity = .init(context: context)
        
        self.products.forEach({ product in

            var entity: ProductEntity = .init(context: context)
            
            entity.id = Int32(product.id)
            entity.createAt = self.getDate()
            entity.title = product.title
            entity.brand = product.brand
            entity.descrip = product.description
            entity.price = Double(product.price)
            entity.discountPrice = product.discountPercentage
            entity.thumb = product.thumbnail
            entity.productsToimages = NSSet(object: product.images)
        })
        
        return productEntity
    }

    public func getDate() -> String {
        let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
        return date
    }

}

extension ProductEntity {
    
    func toDomain() -> ProductItem {
        
        var images = [String]()
        
        productsToimages?.forEach({ item in
            
            images.append(item as! String)
        })
        
        return .init(id: id, title: title!, description: description, price: Int(price), discountPercentage: discountPrice, rating: 5.0, stock: 100, brand: brand ?? "Apple", category: "", thumbnail: thumb!, images: images)
    }
}
