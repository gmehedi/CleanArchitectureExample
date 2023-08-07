//
//  ConnectionError.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/16.
//

import Foundation

protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
