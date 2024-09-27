//
//  WorldDetailsViewModel.swift
//  WorldSia
//
//  Created by Onur Bostan on 24.09.2024.
//

import Foundation

class WorldDetailsViewModel {
    private let country: WorldModel
    
    init(country: WorldModel) {
        self.country = country
    }
    
    var countryName: String {
        return country.name?.common ?? "Unknown"
    }
    
    var latitude: Double? {
        return country.latlng?.first
    }
    
    var longitude: Double? {
        return country.latlng?.last
    }
    
    var capitalName: String {
        return "Capital: \(country.capital?.first ?? "N/A")"
    }
    
    var population: String{
        return "Population: \(country.population)"
    }
    
    var region: String {
        return "Region: \(country.region ?? "N/A")"
    }
    
    var languages: String {
        guard let languages = country.languages else { return "Language: N/A" }
        return "Language: \(languages.map { $0.value }.joined(separator: ", "))"
    }
    
    var currencies: String {
        guard let currencies = country.currencies else { return "Currency: N/A" }
        return "Currency: \(currencies.map { "\($0.value.name) (\($0.value.symbol ?? ""))" }.joined(separator: ", "))"
    }
    
    var capitalInfo: String {
        guard let latlng = country.capitalInfo?.latlng else { return "Capital Info: N/A" }
        return "Capital Info: Lat: \(latlng[0]), Long: \(latlng[1])"
    }
    
    var flagURL: URL? {
        guard let urlString = country.flags?.png else { return nil }
        return URL(string: urlString)
    }

}
