//
//  MainTabBarController.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 17/12/21.
//

import UIKit
import RxSwift
import Foundation

class MainTabBarController: UITabBarController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        delegate = self
        DefaultCharactersUseCase().execute()
            .observe(on: MainScheduler.instance)
            .subscribe { charactersResponse in
                switch charactersResponse {
                case .success(let data):
                    break
                case .failure(let error):
                    break
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
}
