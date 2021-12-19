//
//  CharactersViewController.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import UIKit
import RxCocoa
import RxSwift

class CharactersViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    var viewModel: CharacterViewModel?
    
    private var model: [CharacterModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private let collectionView: UICollectionView = {
        let layout = CustomCollectionViewLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.backgroundColor = .clear
        return collection
    }()
    
    //MARK: - LigeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupBinding()
        viewModel?.viewDidLoad()
    }
}

//MARK: - private methods
private extension CharactersViewController {
    func setupView() {
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    func setupCollectionView() {
        collectionView.register(CharacterListCell.self, forCellWithReuseIdentifier: "characterListCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupBinding() {
        viewModel?.items.bind(listener: { [weak self] items in
            guard let items = items else { return }
            self?.model = items
        })
    }
}

//MARK: - CollectionViewMethods
extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterListCell", for: indexPath) as? CharacterListCell else { return UICollectionViewCell() }
        let hero = model[indexPath.row]
        cell.title.text = hero.name
        if let url = URL(string: hero.imageUrl) {
            cell.imageView.load(url: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == model.count - 1 {
            viewModel?.fetchMoreData()
        }
    }
}
