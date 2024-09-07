//
//  CharactersApiGateMock.swift
//  RickAndMortyTests
//
//  Created by Khaled Hamed on 07/09/2024.
//

import Foundation

@testable import RickAndMorty

class CharactersApiGateMock : CharactersApiGateProtocol {
    
    var getCharactersShouldSuccess : Bool = false
    
    func getCharacters(pageNumber: Int, onSuccess: @escaping (RickAndMorty.CharacterResponseModelData) -> Void, onFailure: @escaping (RickAndMorty.BaseNetworkError) -> Void) {
        
        let characterLocation = CharacterLocation(name: "test location name", url: "test location url")
        
        let characterModel = CharacterModel(id: 1, name: "test name", species: "test species", image: "test image url", location: characterLocation)
        
        let characterResbonseModelData = CharacterResponseModelData(results: [characterModel])
        if getCharactersShouldSuccess {
            onSuccess(characterResbonseModelData)
        }
        onFailure(BaseNetworkError())
    }
    
    
    
}
