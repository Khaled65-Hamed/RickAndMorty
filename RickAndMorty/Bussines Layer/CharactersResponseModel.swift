//
//  CharacterResponseModel.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 28/01/2024.
//

import Foundation

enum CharacterStatus : String {
    case Dead = "Dead"
    case Alive = "Alive"
    case Unknown = "Unknown"
}

class CharacterResponseModelData : Codable {
    internal init(results: [CharacterModel] = []) {
        self.results = results
    }
    
    var results : [CharacterModel] = []
    
    enum CodingKeys : String , CodingKey {
        case results
    }
}


struct CharacterModel : Codable {
    
    internal init(id: Int, name: String, status: String? = nil, species: String, gender: String? = nil, image: String, location: CharacterLocation) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
        self.location = location
    }
    
    var id : Int
    var name : String
    private var status : String?
    var statusValue : CharacterStatus {
        CharacterStatus(rawValue: self.status ?? "") ?? .Unknown
    }
    var species : String
    var gender : String?
    var image : String
    var location : CharacterLocation
    
    
    enum CodingKeys : String , CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case image
        case location
    }
}


struct CharacterLocation : Codable {
    
    internal init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    var name : String
    var url : String
    
    enum CodingKeys : String , CodingKey {
        case name
        case url
    }
}
