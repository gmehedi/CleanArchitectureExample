//
//  UseCase.swift
//  CleanArchitectureExample
//
//  Created by Mehedi on 29/1/24.
//

import Foundation

protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
