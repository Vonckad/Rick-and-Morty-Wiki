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
//    private let gradientLayer = CAGradientLayer()
    private let gradientView = UIView()
    let nameLabel = UILabel()
    let genderLabel = UILabel()
    let speciesLabel = UILabel()
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
        
        gradientView.backgroundColor = .black
        gradientView.alpha = 0.8
        contentView.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(gradientView)
        gradientView.frame = imageView.frame
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        gradientView.addSubview(nameLabel)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.textColor = .white
        gradientView.addSubview(genderLabel)
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.textColor = .white
        gradientView.addSubview(speciesLabel)
        
        contentView.addSubview(actIndicator)
        actIndicator.center = contentView.center
        actIndicator.hidesWhenStopped = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            gradientView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            gradientView.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -8),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            speciesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            speciesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            genderLabel.bottomAnchor.constraint(equalTo: speciesLabel.topAnchor, constant: -8),
            genderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: genderLabel.topAnchor, constant: -8),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
        ])
    }
    
    func hiddenAll(_ flag: Bool) {
        flag ? actIndicator.startAnimating() : actIndicator.stopAnimating()
        nameLabel.isHidden = flag
        imageView.isHidden = flag
        genderLabel.isHidden = flag
        speciesLabel.isHidden = flag
        gradientView.isHidden = flag
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = gradientView.bounds
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//        gradientView.layer.addSublayer(gradientLayer)
//        gradientView.alpha = 0.85
//    }
}
