//
//  SeriesRepositoryProtocol.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation
import RxSwift

protocol SeriesRepository {
    func seriesList(serie: String) -> Single<SeriesListResponse>
    func charactersFromSerie(url: String) -> Single<CharactersListResponse>
}
