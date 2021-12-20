//
//  CharactersRepository.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 17/12/21.
//

import Foundation
import Alamofire
import RxSwift

final class DefaultCharactersRepository: CharactersRepository {
    
    private enum RepoConstants {
        static let limit = 20
    }
    
    func charactersList(skip: Int? = 0) -> Single<CharactersListResponse> {
        return Single.create { single -> Disposable in
            let timeStamp = Utils.getTimeStamp()
            var parameters: [String : Any] = [
                Params.apiKey : Constants.publicKey,
                Params.ts : timeStamp,
                Params.hash : Utils.getHash(timeStamp),
                Params.limitString : RepoConstants.limit
            ]
            
            if let skip = skip {
                parameters[Params.offsetString] = skip
            }
            
            AF.request(Constants.urlBase, parameters: parameters).response { response in
                switch response.data {
                case .some(let data):
                    guard let response = try? JSONDecoder().decode(CharactersListResponse.self, from: data) else {
                        single(.failure(ServiceError.mappingError))
                        return
                    }
                    single(.success(response))
                default:
                    single(.failure(ServiceError.responseError))
                }
            }
            return Disposables.create()
        }
    }
}
