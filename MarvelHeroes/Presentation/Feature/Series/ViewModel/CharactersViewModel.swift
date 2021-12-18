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
    func image()
}

protocol CharacterViewModelOutput {
    var items: Box<[CharacterInfo]?> { get }
    var loadingStatus: Bool? { get }
    var error: Error? { get }
}

class DefaultCharactersViewModel: CharacterViewModel {
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: CharactersUseCase
    
    var items: Box<[CharacterInfo]?> = Box(nil)
    var loadingStatus: Bool?
    var error: Error?

    init(characterUseCase: CharactersUseCase = DefaultCharactersUseCase()) {
        useCase = characterUseCase
    }
    
    func viewDidLoad() {
        updateView()
    }
    
    func updateView() {
        useCase.execute()
            .observe(on: MainScheduler.instance)
            .subscribe{ event in
                switch event {
                case .success(let characterList):
                    self.items.value = characterList.data?.results
                case .failure(let error):
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    func image() {
    }
}
