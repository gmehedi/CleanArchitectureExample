//
//  ManageHistoryProtocol.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/12.
//

import Foundation
import CoreData

protocol ProductsCoreDataManagerProtocol {
    func getResponse(
        for request: ProductsRequestDTO,
        completion: @escaping (Result<ProductsResponseDTO?, Error>) -> Void
    )
    func save(response: ProductsResponseDTO, for requestDto: ProductsRequestDTO)
}
