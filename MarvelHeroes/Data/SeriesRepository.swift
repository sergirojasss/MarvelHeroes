//
//  SeriesRepository.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import Foundation
import Alamofire
import RxSwift

final class DefaultSeriesRepository: SeriesRepository {
    
    private enum RepoConstants {
        static let startsWith = "titleStartsWith"
        static let limit = 5
    }
    
    func seriesList(serie: String) -> Single<SeriesListResponse> {
        return Single.create { single -> Disposable in
            let url = "\(Constants.urlBase)\(Constants.seriesCall)"
            let timeStamp = Utils.getTimeStamp()
            let parameters: [String : Any] = [
                Params.apiKey : Constants.publicKey,
                Params.ts : timeStamp,
                Params.hash : Utils.getHash(timeStamp),
                Params.limitString : RepoConstants.limit,
                RepoConstants.startsWith : serie
            ]
                        
            AF.request(url, parameters: parameters).response { response in
                switch response.data {
                case .some(let data):
                    guard let response = try? JSONDecoder().decode(SeriesListResponse.self, from: data) else {
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
