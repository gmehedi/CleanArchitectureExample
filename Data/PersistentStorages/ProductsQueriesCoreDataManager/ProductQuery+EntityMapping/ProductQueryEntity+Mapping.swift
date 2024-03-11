//
//  File.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 29/1/24.
//

import Foundation
import CoreData

extension ProductQueryEntity {
    convenience init(productsQuery: ProductQuery, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        query = productsQuery.query
        createdAt = Date()
    }
}

extension ProductQueryEntity {
    func toDomain() -> ProductQuery {
        return .init(query: self.query ?? "")
    }
}
