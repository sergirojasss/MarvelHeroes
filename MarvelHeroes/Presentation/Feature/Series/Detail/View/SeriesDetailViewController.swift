//
//  SeriesDetailViewController.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 20/12/21.
//

import UIKit

class SeriesDetailViewController: UIViewController {
    
    var viewModel: SeriesDetailViewModel?
    var characterModel: [CharacterModel]? {
        viewModel?.characters.value
    }
        
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        return label
    }()

    private var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
private extension SeriesDetailViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(collectionView)
        setupConstraints()
        fillView()
    }
    
    func setupCollectionView() {
        collectionView.register(CharacterListCell.self, forCellWithReuseIdentifier: "characterListCell")
        collectionView.dataSource = self
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([

            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constans.itemHeight),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constans.spaceing),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constans.spaceing),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.margin),
            descriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: Constans.itemHeight),

            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constans.margin),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func fillView() {
        viewModel?.image.bind { data in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        Utils.loadImageData(from: viewModel?.imageUrl ?? "") { data in
            self.viewModel?.image.value = data
        }

        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
    }
    
    func setupBinding() {
        viewModel?.characters.bind(listener: { [weak self] items in
            self?.collectionView.reloadData()
        })
    }
}

//MARK: - Collectionview datasource
extension SeriesDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterListCell", for: indexPath) as? CharacterListCell,
              let model = characterModel else { return UICollectionViewCell() }
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
}

//MARK: - Constants
private enum Constans {
    static let margin: CGFloat = 20
    static let spaceing: CGFloat = 10
    static let itemHeight: CGFloat = 200
}
