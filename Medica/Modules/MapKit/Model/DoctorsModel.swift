//
//  DoctorsModel.swift
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
    let item: Item
}

// MARK: - Item
struct Item: Codable {
    let data: [ItemDatum]
}

// MARK: - ItemDatum
struct ItemDatum: Codable {
    let branchID: Int
    let encodeBranchID: String
    let institutionID: Int
    let title, institutionTitle, datumDescription, address: String
    let lat, lng: Double
    let image: String
    let type: Int
    let distance: Double
    let specialty, price, isFavorite: String
    let rate: Int
    let insurances: Insurances
    let services: Services
    
    enum CodingKeys: String, CodingKey {
        case branchID = "branch_id"
        case encodeBranchID = "encode_branch_id"
        case institutionID = "institution_id"
        case title
        case institutionTitle = "institution_title"
        case datumDescription = "description"
        case address, lat, lng, image, type, distance, specialty, price
        case isFavorite = "is_favorite"
        case rate, insurances, services
    }
}

// MARK: - Insurances
struct Insurances: Codable {
    let data: [InsurancesDatum]
}

// MARK: - InsurancesDatum
struct InsurancesDatum: Codable {
    let id: Int
    let title: String
    let address: JSONNull?
}

// MARK: - Services
struct Services: Codable {
    let data: [ServicesDatum]
}

// MARK: - ServicesDatum
struct ServicesDatum: Codable {
    let id: Int
    let title: String
    let price: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

typealias Doctors = [DoctorsModel]
