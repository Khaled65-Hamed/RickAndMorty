//
//  CharactersApiGate.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 27/01/2024.
//

import Foundation


class CharactersApiGate : BaseAPIHandler , CharactersApiGateProtocol{
    
    private enum EndPoints : String {
        case getCharacters = "character"
    }
    
    private enum Attributes : String {
        case PageNumber = "page"
    }
    
    func getCharacters(pageNumber : Int, onSuccess : @escaping (CharacterResponseModelData) -> Void , onFailure : @escaping (BaseNetworkError) -> Void) {
        
        let params : [String : AnyObject] = [Attributes.PageNumber.rawValue : pageNumber as AnyObject]
        let router = CharactersRouter(method: .get, path: EndPoints.getCharacters.rawValue, queryParams: params)
        
        self.performNetworkRequest(forRouter: router, jsonDecoder: JSONDecoder()) { (result: Result<CharacterResponseModelData, BaseNetworkError>) in
            switch result {
            case .success(let response):
                print(response)
                onSuccess(response)
            case .failure(let error):
                onFailure(error)
                print(error)
                
            }
        }
    }
}
