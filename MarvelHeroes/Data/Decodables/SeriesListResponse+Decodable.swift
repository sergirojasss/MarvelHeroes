//
//  SeriesListResponse+Decodable.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation

struct SeriesListResponse: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: SeriesDataInfoResponse?
    
    func toDomain() -> SeriesDetailList {
        return SeriesDetailList(code: code,
                          status: status,
                          copyright: copyright,
                          attributionText: attributionText,
                          attributionHTML: attributionHTML,
                          etag: etag,
                          data: data?.toDomain())
    }
}

struct SeriesDataInfoResponse: Decodable {
    let count: Int?
    let limit: Int?
    let offset: Int?
    let results: [SeriesDetailInfoResponse]?
    
    func toDomain() -> SeriesDataInfo {
        return SeriesDataInfo(count: count, limit: limit, offset: offset, results: results?.map { $0.toDomain() })
    }
}

struct SeriesDetailInfoResponse: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [UrlInfoResponse]?
    let startYear: Int?
    let endYear: Int?
    let rating: String?
    let modified: String?
    let thumbnail: ThumbnailInfoResponse?
    let comics: ComicsListInfoResponse?
    let stories: StoriesListInfoResponse?
    let events: EventsListInfoResponse?
    let characters: CharacterListInfoResponse?
    let creators: CreatorsListInfoResponse?
    let next: SeriesSummaryInfoResponse?
    let previous: SeriesSummaryInfoResponse?

    func toDomain() -> SeriesDetailInfo {
        return SeriesDetailInfo(id: id,
                                title: title,
                                description: description,
                                resourceURI: resourceURI,
                                urls: urls?.map{ $0.toDomain() },
                                startYear: startYear,
                                endYear: endYear,
                                rating: rating,
                                modified: modified,
                                thumbnail: thumbnail?.getFullPath(),
                                comics: comics?.toDomain(),
                                stories: stories?.toDomain(),
                                events: events?.toDomain(),
                                characters: characters?.toDomain(),
                                creators: creators?.toDomain(),
                                next: next?.toDomain(),
                                previous: previous?.toDomain())
    }
}


//TODO: Refactor and rename all Decodables and entities. Little bit confusing some of them
struct CreatorsListInfoResponse: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsInfoResponse]?
    
    func toDomain() -> CreatorsListInfo {
        return CreatorsListInfo(available: available,
                                collectionURI: collectionURI,
                                items: items?.map { $0.toDomain() } ?? [])
    }
}

struct CreatorsInfoResponse: Decodable {
    let name: String?
    let resourceURI: String?
    let role: String?
    
    func toDomain() -> CreatorsInfo {
        return CreatorsInfo(name: name, resourceURI: resourceURI, role: role)
    }
}

struct SeriesSummaryInfoResponse: Decodable {
    let name: String?
    let resourceURI: String?
    
    func toDomain() -> SeriesSummaryInfo {
        return SeriesSummaryInfo(name: name, resourceURI: resourceURI)
    }
}

struct CharacterListInfoResponse: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [CharacterInfoResponse]?
    let returned: Int?
    
    func toDomain() -> CharacterListInfo {
        return CharacterListInfo(available: available,
                              collectionURI: collectionURI,
                              items: items?.map { $0.toDomain() } ,
                              returned: returned)
    }
}

struct CharacterInfoResponse: Decodable {
    let resourceURI: String?
    let name: String?
    
    func toDomain() -> CharacterInfo {
        return CharacterInfo(resourceURI: resourceURI, name: name)
    }
}

