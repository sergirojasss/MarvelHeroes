//
//  SeriesViewModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation
import RxSwift

protocol SeriesViewModel: SeriesViewModelInput, SeriesViewModelOutput {}

protocol SeriesViewModelInput {
    func viewDidLoad()
    func searchSeries(text: String)
    func didSelect(_ row: Int) -> Any?
}

protocol SeriesViewModelOutput {
    var items: Box<[SeriesModel]?> { get }
    var loadingStatus: Bool? { get } //TODO: manage loading view
    var error: Error? { get }
}

struct DefaultSeriesViewModel: SeriesViewModel {
    private let disposeBag = DisposeBag()

    let seriesUseCase: SeriesUseCase
    var items: Box<[SeriesModel]?> = Box([])
    var loadingStatus: Bool?
    var error: Error?
    
    init(useCase: SeriesUseCase = DefaultSeriesUseCase()) {
        seriesUseCase = useCase
    }
    
    func viewDidLoad() {
    }
    
    func searchSeries(text: String) {
        seriesUseCase.execute(startsWith: text)
            .observe(on: MainScheduler.instance)
            .subscribe({ event in
                switch event {
                case .success(let seriesList):
                    self.items.value = seriesList.data?.results?.map { SeriesModel.makeModel(from: $0) }
                case .failure(let error):
                    //TODO: Error case
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func didSelect(_ row: Int) -> Any? {
        return nil
    }
}
