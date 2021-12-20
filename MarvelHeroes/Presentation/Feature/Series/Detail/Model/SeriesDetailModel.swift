//
//  SeriesDetailModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation

struct SeriesDetailModel {
    let title: String?
    let imageUrl: String
    let image: Box<Data?> = Box(nil)
    let description: String?
    let characters: [CharacterModel]
}
