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
