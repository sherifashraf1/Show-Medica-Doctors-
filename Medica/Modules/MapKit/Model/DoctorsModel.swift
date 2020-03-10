//
//  DoctorsListing.swift
//  Medica
//
//  Created by ALY on 3/9/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import Foundation

// MARK: - Doctots
struct DoctorsModel: Codable {
    let code: Int
    let message: String
    let item: ItemList
}

// MARK: - Item
struct ItemList: Codable {
    let data: [ItemDatumList]
}

// MARK: - ItemDatum
struct ItemDatumList: Codable {
    let branch_id: Int
    let encode_branch_id: String
    let institution_id: Int
    let title, institution_title, description, address: String
    let lat, lng: String
    let image: String
    let type: Int
    let distance: Double
    let specialty, price, is_favorite: String
    let rate: Int
}
