//
//  CharacterListResponse+Decodable.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import Foundation

struct CharactersListResponse: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: DataInfoResponse?
    
    func toDomain() -> CharactersList {
        return CharactersList(code: code,
                              status: status,
                              copyright: copyright,
                              attributionText: attributionText,
                              attributionHTML: attributionHTML,
                              etag: etag,
                              data: data?.toDomain())
    }
}

struct DataInfoResponse: Decodable {
    let count: Int?
    let limit: Int?
    let offset: Int?
    let results: [CharacterDetailInfoResponse]?
    
    func toDomain() -> DataInfo {
        return DataInfo(count: count, limit: limit, offset: offset, results: results?.map { $0.toDomain() })
    }
}

struct CharacterDetailInfoResponse: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: ThumbnailInfoResponse?
    let resourceURI: String?
    let comics: ComicsListInfoResponse?
    let series: SeriesListInfoResponse?
    let stories: StoriesListInfoResponse?
    let events: EventsListInfoResponse?
    let urls: [UrlInfoResponse]?
    
    func toDomain() -> CharacterDetailInfo {
        return CharacterDetailInfo(id: id,
                             name: name,
                             description: description,
                             modified: modified,
                             thumbnail: thumbnail?.getFullPath(),
                             resourceURI: resourceURI,
                             comics: comics?.toDomain(),
                             series: series?.toDomain(),
                             stories: stories?.toDomain(),
                             events: events?.toDomain(),
                             urls: urls?.map{ $0.toDomain() })
    }
}

struct ThumbnailInfoResponse: Decodable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
    
    func getFullPath() -> String? {
        guard let path = path, let ext = ext else { return nil }
        return "\(path).\(ext)"
    }
}

struct ComicsListInfoResponse: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicInfoResponse]?
    let returned: Int?
    
    func toDomain() -> ComicsListInfo {
        return ComicsListInfo(available: available,
                              collectionURI: collectionURI,
                              items: items?.map { $0.toDomain() } ,
                              returned: returned)
    }
}

struct ComicInfoResponse: Decodable {
    let resourceURI: String?
    let name: String?
    
    func toDomain() -> ComicInfo {
        return ComicInfo(resourceURI: resourceURI, name: name)
    }
}

struct SeriesListInfoResponse: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [SeriesInfoResponse]?
    let returned: Int?
    
    func toDomain() -> SeriesListInfo {
        return SeriesListInfo(available: available,
                              collectionURI: collectionURI,
                              items: items?.map{ $0.toDomain() },
                              returned: returned)
    }
}

struct SeriesInfoResponse: Decodable {
    let resourceURI: String?
    let name: String?

    func toDomain() -> SeriesInfo {
        return SeriesInfo(resourceURI: resourceURI, name: name)
    }
}

struct StoriesListInfoResponse: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesInfoResponse]?
    let returned: Int?
    
    func toDomain() -> StoriesListInfo {
        return StoriesListInfo(available: available,
                              collectionURI: collectionURI,
                              items: items?.map{ $0.toDomain() },
                              returned: returned)
    }
}

struct StoriesInfoResponse: Decodable {
    let resourceURI: String?
    let name: String?
    
    func toDomain() -> StoriesInfo {
        return StoriesInfo(resourceURI: resourceURI, name: name)
    }
}

struct EventsListInfoResponse: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [EventsInfoResponse]?
    let returned: Int?
    
    func toDomain() -> EventsListInfo {
        return EventsListInfo(available: available,
                              collectionURI: collectionURI,
                              items: items?.map{ $0.toDomain() },
                              returned: returned)
    }
}

struct EventsInfoResponse: Decodable {
    let resourceURI: String?
    let name: String?
    
    func toDomain() -> EventsInfo {
        return EventsInfo(resourceURI: resourceURI, name: name)
    }
}

struct UrlInfoResponse: Decodable {
    let type: String?
    let url: String?
    
    func toDomain() -> UrlInfo {
        return UrlInfo(type: type, url: url)
    }
}
