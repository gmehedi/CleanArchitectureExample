//
//  Logger.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/09.
//

import Foundation

class Logger: NSObject {
    
    static func logPrintWith(text: String?) {
#if DEBUG
        debugPrint(text ?? "")
#endif
    }
    
    static func logPrintWith(any: Any?) {
#if DEBUG
        debugPrint(any as Any)
#endif
    }
    
    
    static func logPrintJsonFrom(model: ProductResponseDTO) {
#if DEBUG
        do {
            let encodedData = (try? JSONEncoder().encode(model))!
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            debugPrint("RequestModel:   " + (jsonString ?? "Nothing"))
        }
#endif
        
    }
}


func readJSONFile(jsonData data: Data) {
#if DEBUG
    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] {
            print("JSON: \(json)")
        } else {
            print("Given JSON is not a valid dictionary object.")
        }
        
    } catch {
        print(error)
    }
#endif
}
