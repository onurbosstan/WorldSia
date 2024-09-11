//
//  WorldServices.swift
//  WorldSia
//
//  Created by Onur Bostan on 11.09.2024.
//

import Foundation
import Alamofire

class WorldServices {
    static let shared = WorldServices()
    
    func fetchCountries(completion: @escaping (Result<[WorldModel], Error>) -> Void) {
        
        guard let url = URL(string: WorldRoutes.baseUrl) else {
            completion(.failure(NSError(domain: "WorldService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        AF.request(url).validate().responseDecodable(of: [WorldModel].self) { response in
            switch response.result {
            case .success(let countries):
                completion(.success(countries))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
