//
//  APIEndpoints.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/12.
//

import Foundation

struct APIEndpoints {
    
    static func getProductResponse(with productsRequestDTO: ProductsRequestDTO) -> Endpoint<ProductResponseDTO> { //Decode type
        
        return Endpoint(
            path: "products",
            method: .get,
            headerParameters: [
                "Accept": "application/json",
                "Content-Type" : "application/json"
            ],
            queryParametersEncodable: productsRequestDTO
        )
        //bodyParametersEncodable: productsRequestDTO
    }

}

