//
//  CharacterListCell.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import UIKit

class CharacterListCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        addSubview(imageView)
        addSubview(title)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        imageView.image = nil
        title.text = ""
    }
}

//MARK: - Private methods
private extension CharacterListCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 20),
            title.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
