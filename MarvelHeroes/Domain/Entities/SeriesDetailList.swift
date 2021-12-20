//
//  SeriesList.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation

struct SeriesDetailList {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: SeriesDataInfo?
}

struct SeriesDataInfo {
    let count: Int?
    let limit: Int?
    let offset: Int?
    let results: [SeriesDetailInfo]?
}

struct SeriesDetailInfo {
    let id: Int?
    let title: String?
    let description: String?
    let resourceURI: String?
    let urls: [UrlInfo]?
    let startYear: Int?
    let endYear: Int?
    let rating: String?
    let modified: String?
    let thumbnail: String?
    let comics: ComicsListInfo?
    let stories: StoriesListInfo?
    let events: EventsListInfo?
    let characters: CharactersList?
    let creators: CreatorsListInfo?
    let next: SeriesSummaryInfo?
    let previous: SeriesSummaryInfo?
}

struct CreatorsListInfo {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsInfo]
}

struct CreatorsInfo {
    let name: String?
    let resourceURI: String?
    let role: String?
}

struct SeriesSummaryInfo {
    let name: String?
    let resourceURI: String?
}
