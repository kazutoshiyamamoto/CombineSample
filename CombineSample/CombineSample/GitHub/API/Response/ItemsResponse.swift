//
//  ItemsResponse.swift
//  CombineSample
//
//  Created by home on 2021/09/03.
//

import Foundation

struct ItemsResponse<Item: Decodable>: Decodable {
    let items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
}
