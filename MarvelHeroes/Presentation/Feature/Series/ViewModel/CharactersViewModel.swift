//
//  CharactersViewModel.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import Foundation
import RxSwift

protocol CharacterViewModel: CharacterViewModelInput, CharacterViewModelOutput {}

protocol CharacterViewModelInput {
    func viewDidLoad()
    func updateView()
    func fetchMoreData()
    func image()
}

protocol CharacterViewModelOutput {
    var items: PublishSubject<[CharacterModel]> { get }
    var loadingStatus: Bool? { get } //TODO: manage loading view
    var error: Error? { get }
}

class DefaultCharactersViewModel: CharacterViewModel {
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: CharactersUseCase
    private var isLoading: Bool = false
    private var addedItems: [CharacterModel] = []
    
    var items: PublishSubject<[CharacterModel]> = PublishSubject<[CharacterModel]>()
    var loadingStatus: Bool?
    var error: Error?

    init(characterUseCase: CharactersUseCase = DefaultCharactersUseCase()) {
        useCase = characterUseCase
    }
    
    func viewDidLoad() {
        updateView()
    }
    
    func fetchMoreData() {
        executeUseCase(moreData: true)
    }
    
    func updateView() {
        executeUseCase(moreData: false)
    }
    
    func image() {
    }
}

//MARK: - Private methods
private extension DefaultCharactersViewModel {
    func executeUseCase(moreData: Bool) {
        if isLoading { return }
        isLoading = true
        useCase.execute(moreData: moreData)
            .observe(on: MainScheduler.instance)
            .subscribe{ event in
                switch event {
                case .success(let characterList):
                    let arrayMaped = characterList.data?.results?.map { CharacterModel.makeModel(from: $0) }
                    self.addedItems.append(contentsOf: arrayMaped ?? [])
                    self.items.onNext(self.addedItems)
                case .failure(_):
                    //TODO: failure case
                    break
                }
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
}
