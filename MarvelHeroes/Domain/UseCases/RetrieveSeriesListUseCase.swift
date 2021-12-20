//
//  RetrieveSeriesListUseCase.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation
import RxSwift

protocol SeriesUseCase {
    func execute(startsWith text: String) -> Single<SeriesDetailList>
}

final class DefaultSeriesUseCase: SeriesUseCase {
    
    private let seriesListRepo: SeriesRepository
    private let disposeBag = DisposeBag()
    
    init(seriesListRepo: SeriesRepository = DefaultSeriesRepository()) {
        self.seriesListRepo = seriesListRepo
    }
    
    func execute(startsWith text: String) -> Single<SeriesDetailList> {
        seriesListRepo.seriesList(serie: text).map({ $0.toDomain() })
    }
}

protocol SeriesDetailUseCase {
    func execute(url: String) -> Single<CharactersList>
}

final class DefaultSeriesDetailUseCase: SeriesDetailUseCase {
    
    private let seriesListRepo: SeriesRepository
    private let disposeBag = DisposeBag()
    
    init(seriesListRepo: SeriesRepository = DefaultSeriesRepository()) {
        self.seriesListRepo = seriesListRepo
    }
    
    func execute(url: String) -> Single<CharactersList> {
        seriesListRepo.charactersFromSerie(url: url).map{ $0.toDomain() }
    }
}

