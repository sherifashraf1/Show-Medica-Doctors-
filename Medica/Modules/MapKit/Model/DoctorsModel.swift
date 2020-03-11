//
//  DoctorsListing.swift
//  Medica
//
//  Created by Sherif on 3/9/20.
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
    let branchId: Int
    let encodeBranchId: String
    let institutionId: Int
    let title, institutionTitle, description, address: String
    let lat, lng: String
    let image: String
    let type: Int
    let distance: Double
    let specialty, price, isFavorite: String
    let rate: Int

}
