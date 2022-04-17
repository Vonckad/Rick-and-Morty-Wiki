//
//  CharacterCollectionViewCell.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 17.04.22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "character-cell-reuse-identifier"
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let actIndicator = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension CharacterCollectionViewCell {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(actIndicator)
        actIndicator.center = contentView.center
        actIndicator.hidesWhenStopped = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8)
        ])
    }
    
    func hiddenAll(_ flag: Bool) {
        flag ? actIndicator.startAnimating() : actIndicator.stopAnimating()
        nameLabel.isHidden = flag
        imageView.isHidden = flag
    }
}
