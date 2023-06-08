//
//  InfoEntity.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 6/6/23.
//

struct Info: Codable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?
    
    enum CodingKeys: CodingKey {
        case count
        case pages
        case next
        case prev
    }
}
