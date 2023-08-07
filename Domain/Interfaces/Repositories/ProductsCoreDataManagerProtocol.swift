//
//  ManageHistoryProtocol.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/12.
//

import Foundation
import CoreData

protocol ProductsCoreDataManagerProtocol {
    func fetchProducts(completion: @escaping (([ProductItem]) -> Void) )
    func saveProducts(products: [ProductItemDTO], completion: @escaping ((Bool) -> Void) )
}
