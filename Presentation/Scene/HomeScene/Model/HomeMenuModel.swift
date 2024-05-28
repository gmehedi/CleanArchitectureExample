//
//  HistoryTemplate.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/18.
//

import Foundation

enum HomeActionType: Int {
    case getProduct = 0, searchProduct, addProduct
}

class HomeMenuModel {
    
    var title: String
    var iconName: String
    var actionType: HomeActionType
    
    init(title: String, iconName: String, actionType: HomeActionType) {
        self.title = title
        self.iconName = iconName
        self.actionType = actionType
    }
    
}
