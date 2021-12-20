//
//  SeriesDetailViewModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation
import RxSwift

protocol SeriesDetailViewModel: SeriesDetailViewModelInput, SeriesDetailViewModelOutput {}

protocol SeriesDetailViewModelInput {
    func viewDidLoad()
}

protocol SeriesDetailViewModelOutput {
    var title: String? { get }
    var imageUrl: String? { get }
    var description: String? { get }
    var charactersUrl: String? { get }
    var characters: Box<[CharacterModel]?> { get }
    var image: Box<Data?> { get }
}

struct DefaultSeriesDetailViewModel: SeriesDetailViewModel {
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: SeriesDetailUseCase
    
    var title: String?
    var imageUrl: String?
    var image: Box<Data?> = Box(nil)
    var description: String?
    var charactersUrl: String?
    var characters: Box<[CharacterModel]?> = Box([])

    init(model: SeriesDetailModel, useCase: SeriesDetailUseCase = DefaultSeriesDetailUseCase()) {
        self.useCase = useCase

        title = model.title
        imageUrl = model.imageUrl
        description = model.description
        charactersUrl = model.charactersUrl
    }
    
    func viewDidLoad() {
        useCase.execute(url: charactersUrl ?? "")
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let characterList):
                    self.characters.value = characterList.data?.results?.map { CharacterModel.makeModel(from: $0) }
                case .failure(_):
                    //TODO: failure case
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}
