//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Khaled Hamed on 07/09/2024.
//

import SwiftUI

struct CharacterImage: View {
    var characterDetails : CharacterModel!
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        AsyncImage(url: URL(string: characterDetails.image)) { image in
            image.resizable()
        } placeholder: {
            Color.gray
        }
        .frame(width: screenWidth, height: (screenHeight * 40/100))
        .cornerRadius(25)
    }
}

struct CharacterDetails: View {
    var characterDetails : CharacterModel!
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                
                // Character Information
                Text("\(characterDetails.name)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                HStack{
                    Text("\(characterDetails.species) • ")
                        .fontWeight(.semibold)
                        
                    Text("\(characterDetails.gender ?? "")")
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                
                HStack {
                    Text("Location:")
                        .fontWeight(.semibold)
                    
                    Text("\(characterDetails.location.name)")
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                .padding(.top, 20)
            }
            .padding(.horizontal)
            
            Spacer()
             
            Text("Status")
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            .padding()
        }
        Spacer()
        
    }
}

struct CharacterDetailsViewController: View {
    
    var characterDetails : CharacterModel!
    
    var body: some View {
        VStack {
            CharacterImage(characterDetails: characterDetails)
            CharacterDetails(characterDetails: characterDetails)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CharacterDetails()
}
