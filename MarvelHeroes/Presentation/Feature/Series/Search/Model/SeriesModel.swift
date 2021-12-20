//
//  SeriesModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation

struct SeriesModel {
    
    var title: String?
    var imageUrl: String?
    var description: String?
    var charactersCollectionURI: String?
    
    static func makeModel(from domain: SeriesDetailInfo) -> SeriesModel {
        return SeriesModel(title: domain.title,
                           imageUrl: domain.thumbnail,
                           description: domain.description,
                           charactersCollectionURI: domain.characters?.collectionURI)
    }
}
