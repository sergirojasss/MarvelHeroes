//
//  CharacterDetailViewModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 19/12/21.
//

import Foundation

struct CharacterDetailViewModel {
    
    var name: String
    var image: Data?
    var description: String?
    var comics: [String]?
    var comicsUri: String?
    var stories: [String]?
    var storiesUri: String?

    init(model: CharacterDetailModel) {
        name = model.name
        image = model.image
        description = model.description
        comics = model.comics?.items?.map({ (addedInfoModel) -> String in
            addedInfoModel.name ?? ""
        })
        comicsUri = model.comics?.collectionURI
        stories = model.stories?.items?.map({ (addedInfoModel) -> String in
            addedInfoModel.name ?? ""
        })
        storiesUri = model.stories?.collectionURI
    }
}
