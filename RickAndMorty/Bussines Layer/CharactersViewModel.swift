//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 06/09/2024.
//

import Foundation

protocol CharactersViewModelProtocol {
    func getCharacters(onSuccess : @escaping (CharacterResponseModelData) -> Void , onFailure : @escaping (BaseNetworkError) -> Void)
    func getFilteredArray(filteredType : CharacterStatus) -> [CharacterModel]
    
    var pageNumber : Int {get set}
    var filterData : [CharacterStatus] {get}
    var originalCharactersArray : [CharacterModel] {get set}
}

class CharactersViewModel : CharactersViewModelProtocol {
    
    var charactersApiGate : CharactersApiGateProtocol!
    var pageNumber : Int = 1
    
    var filterData : [CharacterStatus] = [.Alive , .Dead , .Unknown]
    var originalCharactersArray : [CharacterModel] = []
    
    init(charactersApiGate: CharactersApiGateProtocol) {
        self.charactersApiGate = charactersApiGate
    }
    
    func getCharacters(onSuccess : @escaping (CharacterResponseModelData) -> Void , onFailure : @escaping (BaseNetworkError) -> Void) {
        self.charactersApiGate.getCharacters(pageNumber: pageNumber, onSuccess: { rates in
            onSuccess(rates)
        }, onFailure: { error in
            onFailure(error)
        })
    }
    
    func getFilteredArray(filteredType : CharacterStatus) -> [CharacterModel] {
        let filteredData = self.originalCharactersArray.filter{$0.statusValue == filteredType}
        return filteredData
    }
}
