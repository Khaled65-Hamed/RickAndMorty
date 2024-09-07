//
//  CharactersViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Khaled Hamed on 07/09/2024.
//

import Foundation
import XCTest

@testable import RickAndMorty

class CharactersViewModelTests : XCTestCase {
    
    var viewModel: CharactersViewModel!
    var apiManager: CharactersApiGateMock!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiManager = CharactersApiGateMock()
        viewModel = CharactersViewModel(charactersApiGate: apiManager)
        
    }
    
    func test_GetCharacters_OnApiSuccess_OnSuccessClosureCalled() {
        
        //Arrange
        apiManager.getCharactersShouldSuccess = true
        var isSuccessClousreCalled = false
        
        //Act
        viewModel.getCharacters { _ in
            isSuccessClousreCalled = true
        } onFailure: { _ in
            
        }
        
        //Assert
        XCTAssertTrue(isSuccessClousreCalled)
    }
    
    func test_GetCharacters_OnApiFailed_OnSuccessFailureClosureCalled() {
        
        //Arrange
        apiManager.getCharactersShouldSuccess = false
        var isSuccessClousreCalled = false
        
        //Act
        viewModel.getCharacters { _ in
            isSuccessClousreCalled = true
        } onFailure: { _ in
            
        }
        
        //Assert
        XCTAssertFalse(isSuccessClousreCalled)
    }
    
    
    func test_GetCharacters_OnApiSucceed_OnFailureClosureNotCalled() {
        
        //Arrange
        apiManager.getCharactersShouldSuccess = true
        var isFailureClosureCalled = false
        
        //Act
        viewModel.getCharacters { _ in
            isFailureClosureCalled = false
        } onFailure: { _ in
    
        }
        
        //Assert
        XCTAssertFalse(isFailureClosureCalled)
    }
    
    func test_GetCharacters_OnApiFailed_OnFailureClosureCalled() {
        
        //Arrange
        apiManager.getCharactersShouldSuccess = false
        var isFailureClosureCalled = false
        
        //Act
        viewModel.getCharacters { _ in

        } onFailure: { _ in
            isFailureClosureCalled = true
        }
        
        //Assert
        XCTAssertTrue(isFailureClosureCalled)
    }
    
    func test_filteredArray_AliveFilterSelected_ReturnedArrayNotContainDeadCharacters() {
        
        //Arrange
        let selectedValue : CharacterStatus = .Alive
        
        //Act
        
        let filteredData = self.viewModel.getFilteredArray(filteredType: selectedValue)
        
        //Assert
        XCTAssertFalse(filteredData.contains(where: {$0.statusValue == .Dead}))
        
    }
    
    func test_filteredArray_AliveFilterSelected_ReturnedArrayNotContainUnknownCharacters() {
        
        //Arrange
        let selectedValue : CharacterStatus = .Alive
        
        //Act
        
        let filteredData = self.viewModel.getFilteredArray(filteredType: selectedValue)
        
        //Assert
        XCTAssertFalse(filteredData.contains(where: {$0.statusValue == .Unknown}))
        
    }
}
