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
        
        tabBar.items?[0].title = "Heroes"
        tabBar.items?[0].image = UIImage(named: "ironman")?.withTintColor(.black) 
        tabBar.items?[1].title = "Comics"
        tabBar.items?[1].image = UIImage(named: "deadpool")?.withTintColor(.black)
        
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


