//
//  ProductsRequestDTO.swift
//  APIDemo
//
//  Created by M M Mehedi Hasan on 2023/08/05.
//

import Foundation

struct ProductsRequestDTO: Encodable {
    let query: String
    let page: Int
}
