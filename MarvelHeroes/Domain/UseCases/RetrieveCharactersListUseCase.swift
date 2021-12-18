//
//  RetrieveCharactersListUseCase.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import Foundation
import RxSwift

protocol CharactersUseCase {
    func execute() -> Single<CharactersList>
}

final class DefaultCharactersUseCase: CharactersUseCase {
    
    private let charactersListRepo: CharactersRepository
    
    init(charactersListRepo: CharactersRepository = DefaultCharactersRepository()) {
        self.charactersListRepo = charactersListRepo
    }
    
    func execute() -> Single<CharactersList> {
        return charactersListRepo.charactersList().map{ $0.toDomain() }
    }
}
