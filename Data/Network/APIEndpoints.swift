//
//  APIEndpoints.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/12.
//

import Foundation

struct APIEndpoints {
    
    //MARK: Provide Fetching Products EndPoint
    static func getFetchProductsEndpoint(with productsRequestDTO: ProductsRequestDTO) -> Endpoint<ProductResponseDTO> { //Decode type
        
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
    
    //MARK: Provide Fetching Searching Products EndPoint
    static func getSearchProductsEndpoint(with productsRequestDTO: ProductsRequestDTO) -> Endpoint<ProductResponseDTO> { //Decode type
        
        return Endpoint(
            path: "products/search",
            method: .get,
            headerParameters: [
                "Accept": "application/json",
                "Content-Type" : "application/json"
            ],
            queryParametersEncodable: productsRequestDTO
        )
        //bodyParametersEncodable: productsRequestDTO
    }
    
    //MARK: Provide Add Product EndPoint
    static func getAddProductEndpoint(with productItemDictionary: [String : AnyObject]) -> Endpoint<ProductItemDTO> { //Decode type
        
        return Endpoint(
            path: "products/add",
            method: .post,
            headerParameters: [
                "Accept": "application/json",
                "Content-Type" : "application/json"
            ], 
            bodyParameters: productItemDictionary,
            bodyEncoding: .jsonSerializationData
        )
        //bodyParametersEncodable: productsRequestDTO
    }

}

