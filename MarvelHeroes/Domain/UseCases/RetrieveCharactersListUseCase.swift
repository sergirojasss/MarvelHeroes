//
//  RetrieveCharactersListUseCase.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import Foundation
import RxSwift

protocol CharactersUseCase {
    func execute(moreData: Bool) -> Single<CharactersList>
}

final class DefaultCharactersUseCase: CharactersUseCase {
    
    private enum Constants {
        static let nextPage = 20
    }
    
    private let charactersListRepo: CharactersRepository
    private var page: Int = 0
    
    init(charactersListRepo: CharactersRepository = DefaultCharactersRepository()) {
        self.charactersListRepo = charactersListRepo
    }
    
    func execute(moreData: Bool) -> Single<CharactersList> {
        if moreData { page += Constants.nextPage }
        return charactersListRepo.charactersList(skip: page).map{ $0.toDomain() }
    }
}
