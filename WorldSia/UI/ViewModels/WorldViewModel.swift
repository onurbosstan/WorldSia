//
//  WorldViewModel.swift
//  WorldSia
//
//  Created by Onur Bostan on 14.09.2024.
//

import Foundation
import Alamofire

class WorldViewModel {
    private var countries:[WorldModel] = []
    
    func fetchCountries(completion: @escaping () -> Void) {
        WorldServices.shared.fetchCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countries = countries
                completion()
            case .failure(let error):
                print("Veri çekme hatası: \(error.localizedDescription)")
                completion()
            }
        }
    }
    func numberOfItems() -> Int {
        return countries.count
    }
    func country(at index: Int) -> WorldModel? {
        guard index >= 0 && index < countries.count else { return nil }
        return countries[index]
    }
}
