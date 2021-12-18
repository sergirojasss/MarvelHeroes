//
//  CharactersRepository.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 17/12/21.
//

import Foundation
import Alamofire
import RxSwift

final class DefaultCharactersRepository {
    
}

extension DefaultCharactersRepository: CharactersRepository {
    
    private enum RepoConstants {
        static let apiKey = "apikey"
        static let ts = "ts"
        static let hash = "hash"
        static let limitString = "limit"
        static let limit = 20
        static let offsetString = "offset"
    }
    
    func charactersList(skip: Int? = 0) -> Single<CharactersListResponse> {
        return Single.create { single -> Disposable in
            let timeStamp = Utils.getTimeStamp()
            var parameters: [String : Any] = [
                RepoConstants.apiKey : Constants.publicKey,
                RepoConstants.ts : timeStamp,
                RepoConstants.hash : Utils.getHash(timeStamp),
                RepoConstants.limitString : RepoConstants.limit
            ]
            
            if let skip = skip {
                parameters[RepoConstants.offsetString] = skip
            }
            
            AF.request(Constants.urlBase, parameters: parameters).response { response in
                switch response.data {
                case .some(let data):
                    guard let response = try? JSONDecoder().decode(CharactersListResponse.self, from: data) else {
                        single(.failure(RepositoryError.mappingError))
                        return
                    }
                    single(.success(response))
                default:
                    single(.failure(RepositoryError.responseError))
                }
            }
            return Disposables.create()
        }
    }
}

enum RepositoryError: Error {
    case responseError
    case mappingError
}
