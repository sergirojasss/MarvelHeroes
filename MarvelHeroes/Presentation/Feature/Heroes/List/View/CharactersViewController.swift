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
            self?.collectionView.reloadData()
        })
    }
}

//MARK: - CollectionViewMethods
extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterListCell", for: indexPath) as? CharacterListCell,
              let model = viewModel?.items.value else { return UICollectionViewCell() }
        let hero = model[indexPath.row]
        cell.title.text = hero.name
        
        // if the image is already loaded
        if let imageData = hero.image.value,
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        } else { // load image from url
            hero.image.bind { data in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            }
            Utils.loadImageData(from: hero.imageUrl) { data in
                hero.image.value = data
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel?.items.value?.count ?? 0) - 1 {
            viewModel?.fetchMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let controller = viewModel?.didSelect(indexPath.row) {
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}
