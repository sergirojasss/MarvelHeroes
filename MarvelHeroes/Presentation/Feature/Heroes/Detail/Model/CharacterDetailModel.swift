//
//  CharacterDetailModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 19/12/21.
//

import Foundation

struct CharacterDetailModel {
    var name: String
    var image: Data?
    var description: String?
    var comics: AddedInfoListModel?
    var stories: AddedInfoListModel?
}
