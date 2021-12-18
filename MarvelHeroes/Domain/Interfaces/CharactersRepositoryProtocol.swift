//
//  CharactersRepositoryProtocol.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 17/12/21.
//

import Foundation
import RxSwift

protocol CharactersRepository {
    func charactersList() -> Single<CharactersListResponse>
}
