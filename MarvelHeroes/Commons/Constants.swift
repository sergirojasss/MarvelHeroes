//
//  Constants.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 17/12/21.
//

import Foundation

public enum Constants {
    static let urlBase = "https://gateway.marvel.com"
    static let charactersCall = "/v1/public/characters"
    static let seriesCall = "/v1/public/series"
    static let publicKey = "aa8d3daa1e6d77ea7a0905cef180201f"
    static let privateKey = "302dfcf452df511a6e481ce1950c8f1260f056cd"
    
}

public enum Params {
    static let apiKey = "apikey"
    static let ts = "ts"
    static let hash = "hash"
    static let limitString = "limit"
    static let offsetString = "offset"
}

enum ServiceError: Error {
    case responseError
    case mappingError
}
