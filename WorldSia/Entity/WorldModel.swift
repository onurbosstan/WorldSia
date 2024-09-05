//
//  WorldModel.swift
//  WorldSia
//
//  Created by Onur Bostan on 5.09.2024.
//

import Foundation

// MARK: - WelcomeElement
struct WorldModel: Codable {
    let name: Name
    let tld: [String]
    let cca2, ccn3, cca3: String
    let independent: Bool
    let status: String
    let unMember: Bool
    let currencies: Currencies
    let idd: Idd
    let capital, altSpellings: [String]
    let region: String
    let languages: Languages
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let area: Int
    let demonyms: Demonyms
    let flag: String
    let maps: Maps
    let population: Int
    let car: Car
    let timezones, continents: [String]
    let flags: Flags
    let coatOfArms: CoatOfArms
    let startOfWeek: String
    let capitalInfo: CapitalInfo
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]
    let side: String
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
}

// MARK: - Currencies
struct Currencies: Codable {
    let shp: Shp

    enum CodingKeys: String, CodingKey {
        case shp = "SHP"
    }
}

// MARK: - Shp
struct Shp: Codable {
    let name, symbol: String
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng: Eng
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
}

// MARK: - Idd
struct Idd: Codable {
    let root: String
    let suffixes: [String]
}

// MARK: - Languages
struct Languages: Codable {
    let eng: String
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: NativeName
}

// MARK: - NativeName
struct NativeName: Codable {
    let eng: Translation
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

typealias World = [WorldModel]
