//
//  CharactersModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import Foundation

struct CharacterModel {
    let name: String
    let imageUrl: String
    let image: Box<Data?> = Box(nil)
    
    static func makeModel(from domain: CharacterInfo) -> CharacterModel {
        return CharacterModel(name: domain.name ?? "", imageUrl: domain.thumbnail ?? "")
    }
}
