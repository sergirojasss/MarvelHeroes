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
            if let navC = controller as? UINavigationController {
                if let controller = navC.viewControllers.first as? CharactersViewController {
                    controller.viewModel = DefaultCharactersViewModel()
                } else if let controller = navC.viewControllers.first as? SeriesViewController {
                    controller.viewModel = DefaultSeriesViewModel()
                }
                
            }
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
}
