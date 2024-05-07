//
//  Item.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 7/5/2024.
//


import SwiftUI


struct Item: Identifiable,Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.title == rhs.title && lhs.image == rhs.image
    }
    
    private(set) var id: UUID = .init()
    var title: String
    var image: UIImage?
    
}
