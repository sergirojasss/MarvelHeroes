//
//  MainTabBarController.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 17/12/21.
//

import RxSwift
import Foundation

class MainTabBarController: UITabBarController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        delegate = self
        for controller in viewControllers ?? [] {
            if let controller = controller as? CharactersViewController {
                controller.viewModel = DefaultCharactersViewModel()
            }
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
}
