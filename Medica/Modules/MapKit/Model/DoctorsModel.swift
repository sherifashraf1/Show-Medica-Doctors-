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
    let branchID: Int
    let encodeBranchID: String
    let institutionID: Int
    let title, institutionTitle, description, address: String
    let lat, lng: String
    let image: String
    let type: Int
    let distance: Double
    let specialty, price, isFavorite: String
    let rate: Int
    
    enum CodingKeys: String, CodingKey {
        case branchID = "branch_id"
        case encodeBranchID = "encode_branch_id"
        case institutionID = "institution_id"
        case institutionTitle = "institution_title"
        case title, description, address, lat, lng, image, type, distance, specialty, price, rate
        case isFavorite = "is_favorite"
    }

}
