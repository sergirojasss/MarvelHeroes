//
//  CharacterList.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import Foundation

struct CharactersList {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: DataInfo?
}

struct DataInfo {
    let count: Int?
    let limit: Int?
    let offset: Int?
    let results: [CharacterDetailInfo]?
}

struct CharacterDetailInfo {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: String?
    let resourceURI: String?
    let comics: ComicsListInfo?
    let series: SeriesListInfo?
    let stories: StoriesListInfo?
    let events: EventsListInfo?
    let urls: [UrlInfo]?
}

struct ComicsListInfo {
    let available: Int?
    let collectionURI: String?
    let items: [ComicInfo]?
    let returned: Int?
}

struct ComicInfo {
    let resourceURI: String?
    let name: String?
}

struct SeriesListInfo {
    let available: Int?
    let collectionURI: String?
    let items: [SeriesInfo]?
    let returned: Int?
}

struct SeriesInfo {
    let resourceURI: String?
    let name: String?
}

struct StoriesListInfo {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesInfo]?
    let returned: Int?
}

struct StoriesInfo {
    let resourceURI: String?
    let name: String?
}

struct EventsListInfo {
    let available: Int?
    let collectionURI: String?
    let items: [EventsInfo]?
    let returned: Int?
}

struct EventsInfo {
    let resourceURI: String?
    let name: String?
}

struct UrlInfo {
    let type: String?
    let url: String?
}
