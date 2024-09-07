//
//  CharactersApiGateProtocol.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 28/01/2024.
//

import Foundation

protocol CharactersApiGateProtocol {
    func getCharacters(pageNumber : Int, onSuccess : @escaping (CharacterResponseModelData) -> Void , onFailure : @escaping (BaseNetworkError) -> Void)
}
