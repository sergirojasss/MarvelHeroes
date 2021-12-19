//
//  CharacterDetailView.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 19/12/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var viewModel: CharacterDetailViewModel?
    
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
    
    private let comicsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        return label
    }()

    //MARK: - LigeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        setupCollectionView()
//        setupBinding()
//        viewModel?.viewDidLoad()
    }
    
}

//MARK: - private methods
private extension CharacterDetailViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(comicsLabel)
        setupConstraints()
        fillView()
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -20),
            descriptionLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

            comicsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            comicsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: safeArea.leadingAnchor, constant: 20),
            comicsLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor, constant: -20),
            comicsLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

        ])
    }
    
    func fillView() {
        if let data = viewModel?.image,
           let image = UIImage(data: data) {
            imageView.image = image
        }
        
        titleLabel.text = viewModel?.name
        descriptionLabel.text = viewModel?.description
        comicsLabel.text = viewModel?.comics?.joined(separator: "\n\n")
    }
}
