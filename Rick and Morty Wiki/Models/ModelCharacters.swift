//
//  ModelCharacters.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 16.04.22.
//

import Foundation

struct ModelCharacters: Decodable {
    var info: InfoCharacters
    var results: [ResultsCharacters]
}

struct InfoCharacters: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct ResultsCharacters: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: LocationCharacters
    var location: LocationCharacters
    var image: String
    var episode: [String]
    var url: String?
    var created: String?
}

struct LocationCharacters: Decodable {
    var name: String
    var url: String
}
