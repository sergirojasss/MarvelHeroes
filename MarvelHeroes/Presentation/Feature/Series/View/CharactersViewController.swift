//
//  CharactersViewController.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import UIKit

class CharactersViewController: UIViewController {
    
    var viewModel: CharacterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
}
