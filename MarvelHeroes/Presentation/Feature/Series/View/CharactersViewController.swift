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
    
    private var model: PublishSubject<[CharacterModel]> = PublishSubject<[CharacterModel]>()
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
        viewModel?.items.bind(to: collectionView
                    .rx
                    .items(cellIdentifier: "characterListCell",
                           cellType: CharacterListCell.self)) { row, model, cell in
            //TODO: Avoid reloading visible cells
            cell.title.text = model.name
            //TODO: add cache
            if let url = URL(string: model.imageUrl) {
                cell.imageView.load(url: url)
            }
        }.disposed(by: disposeBag)
        
        collectionView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.collectionView.contentOffset.y
            let contentHeight = self.collectionView.contentSize.height

            if offSetY > (contentHeight - self.collectionView.frame.size.height - 100) {
                self.viewModel?.fetchMoreData()
            }
        }
        .disposed(by: disposeBag)

    }
}
