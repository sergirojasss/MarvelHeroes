//
//  CharacterDetailView.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 19/12/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var viewModel: CharacterDetailViewModel?
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
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
        
        label.numberOfLines = ControllerConstants.infiniteLines
        return label
    }()

    private var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let comicsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = ControllerConstants.oneLine
        label.font = .boldSystemFont(ofSize: ControllerConstants.fontSize)
        label.text = ControllerConstants.comics
        return label
    }()

    private let comicsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = ControllerConstants.infiniteLines
        return label
    }()

    private let storiesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = ControllerConstants.stories
        label.numberOfLines = ControllerConstants.oneLine
        label.font = .boldSystemFont(ofSize: ControllerConstants.fontSize)
        return label
    }()

    private let storiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = ControllerConstants.infiniteLines
        return label
    }()

    //MARK: - LigeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

//MARK: - private methods
private extension CharacterDetailViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(comicsTitleLabel)
        contentView.addSubview(comicsLabel)
        contentView.addSubview(storiesTitleLabel)
        contentView.addSubview(storiesLabel)
        setupConstraints()
        fillView()
    }
    
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Margins.imageHeight),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Margins.spacing),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margins.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.margins),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.margins),

            comicsTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Margins.bigSpacing),
            comicsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.margins),
            comicsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.margins),

            comicsLabel.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: Margins.spacing),
            comicsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.margins),
            comicsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.margins),

            storiesTitleLabel.topAnchor.constraint(equalTo: comicsLabel.bottomAnchor, constant: Margins.bigSpacing),
            storiesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.margins),
            storiesTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.margins),

            storiesLabel.topAnchor.constraint(equalTo: storiesTitleLabel.bottomAnchor, constant: Margins.spacing),
            storiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.margins),
            storiesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.margins),
            storiesLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
        
    func fillView() {
        if let data = viewModel?.image,
           let image = UIImage(data: data) {
            imageView.image = image
        }
        
        titleLabel.text = viewModel?.name
        descriptionLabel.text = viewModel?.description
        comicsLabel.text = viewModel?.comics?.joined(separator: ControllerConstants.jumpLine)
        storiesLabel.text = viewModel?.stories?.joined(separator: ControllerConstants.jumpLine)
    }
}

private enum Margins {
    static let margins: CGFloat = 20
    static let spacing: CGFloat = 10
    static let bigSpacing: CGFloat = 50
    static let imageHeight: CGFloat = 200
}

private enum ControllerConstants {
    static let comics = "comics".uppercased()
    static let stories = "stories".uppercased()
    static let oneLine = 1
    static let infiniteLines = 0
    static let fontSize: CGFloat = 21
    static let jumpLine = "\n\n"
}
