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
    func fetchMoreData()
    func didSelect(_ row: Int) -> UIViewController
}

protocol SeriesViewModelOutput {
    var items: Box<[SeriesModel]?> { get }
    var loadingStatus: Bool? { get } //TODO: manage loading view
    var error: Error? { get }
}

struct DefaultSeriesViewModel: SeriesViewModel {
    let seriesUseCase: SeriesUseCase
    var items: Box<[SeriesModel]?> = Box([])
    var loadingStatus: Bool?
    var error: Error?
    
    init(useCase: SeriesUseCase = DefaultSeriesUseCase()) {
        seriesUseCase = useCase
    }
    
    func viewDidLoad() {
    }
    
    func fetchMoreData() {
    }
    
    func didSelect(_ row: Int) -> UIViewController {
        return UIViewController()
    }
}
