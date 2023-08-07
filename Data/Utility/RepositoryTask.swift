//
//  File.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/12.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}

