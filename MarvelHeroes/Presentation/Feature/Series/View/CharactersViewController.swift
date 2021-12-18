//
//  CharactersViewController.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import UIKit
import RxCocoa

class CharactersViewController: UIViewController {
    
    var viewModel: CharacterViewModel?
    
    private var model: [CharacterModel] = [] {
        didSet {
            self.collectionView.reloadData()
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupBinding() {
        viewModel?.items.bind(listener: { [weak self] items in
            guard let items = items else { return }
            self?.model = items.map { CharacterModel.makeModel(from: $0) }
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
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        //TODO: add cache
        if let url = URL(string: hero.imageUrl) {
            cell.imageView.load(url: url)
        }
        
        return cell
    }
}
