//
//  CharacterClient.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import Foundation

class CharacterClient {
    
    //MARK: Properties
    enum Constants {
        static let baseURL: String = "https://rickandmortyapi.com/api/"
        static let character = "character"
    }
    
    //MARK: Methods
    static func getFirstResult() async throws -> ResultEntity {
        guard let url = URL(string: Constants.baseURL + Constants.character) else { throw Errors.invalidURL }

        // We will use the async variant of URLSession to fetch data
        let (data, _) = try await URLSession.shared.data(from: url)

        // Parse JSON data
        let result = try JSONDecoder().decode(ResultEntity.self, from: data)
        return result
    }
    
    
}
