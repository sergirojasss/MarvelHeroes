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
    let characterDescription: String
    let comics: AddedInfoListModel?
    let stories: AddedInfoListModel?
    
    static func makeModel(from domain: CharacterDetailInfo) -> CharacterModel {
        return CharacterModel(name: domain.name ?? "",
                              imageUrl: domain.thumbnail ?? "",
                              characterDescription: domain.description ?? "",
                              comics: AddedInfoListModel.makeModel(from: domain.comics),
                              stories: AddedInfoListModel.makeModel(from: domain.stories))
    }
}

struct AddedInfoListModel {
    let collectionURI: String?
    let items: [AddedInfoModel]?
    
    static func makeModel(from domain: ComicsListInfo?) -> AddedInfoListModel? {
        guard let domain = domain else {
            return nil
        }
        return AddedInfoListModel(collectionURI: domain.collectionURI,
                                  items: domain.items?.map{ AddedInfoModel.makeModel(from: $0) })
    }
    
    static func makeModel(from domain: StoriesListInfo?) -> AddedInfoListModel? {
        guard let domain = domain else {
            return nil
        }
        return AddedInfoListModel(collectionURI: domain.collectionURI,
                                  items: domain.items?.map{ AddedInfoModel.makeModel(from: $0) })
    }
}

struct AddedInfoModel {
    let comicUri: String?
    let name: String?
    
    static func makeModel(from domain: ComicInfo) -> AddedInfoModel {
        return AddedInfoModel(comicUri: domain.resourceURI,
                              name: domain.name)
    }

    static func makeModel(from domain: StoriesInfo) -> AddedInfoModel {
        return AddedInfoModel(comicUri: domain.resourceURI,
                              name: domain.name)
    }
}
