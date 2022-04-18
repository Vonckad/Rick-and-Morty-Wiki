//
//  DetailViewController.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 17.04.22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
        
    private var id: Int
    private var characterModel: ResultsCharacters? {
        didSet {
            loadImage()
            nameLabel.attributedText = setupText(bolt: "Name: ", normal: characterModel?.name ?? "")
            speciesLabel.attributedText = setupText(bolt: "Species: ", normal: characterModel?.species ?? "")
            genderLabel.attributedText = setupText(bolt: "Gender: ", normal: characterModel?.gender ?? "")
            episodeCountLabel.attributedText = setupText(bolt: "Episode count: ", normal: "\(characterModel?.episode.count ?? 0)")
            statusLabel.attributedText = setupText(bolt: "Status: ", normal: characterModel?.status ?? "")
            locationLabel.attributedText = setupText(bolt: "Location: ", normal: characterModel?.location.name ?? "")
            title = characterModel?.name ?? ""
        }
    }
    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    private var speciesLabel: UILabel!
    private var genderLabel: UILabel!
    private var episodeCountLabel: UILabel!
    private var statusLabel: UILabel!
    private var locationLabel: UILabel!
    private let serviceFetcher: ServiceFetcherProtocol = ServiceFetcher()
    private var activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        configureActivityIndicatorView()
        loadCharacter()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.layer.position = view.center
    }
    
    private func loadCharacter() {
        self.activityIndicatorView.isHidden = false
        self.activityIndicatorView.startAnimating()
        serviceFetcher.fetchCharactersById(searchItem: String(id)) { resultsCharacters in
            if resultsCharacters == nil {
                self.createAlertView()
            }
            self.activityIndicatorView.stopAnimating()
            self.characterModel = resultsCharacters
        }
    }
    
    private func setupText(bolt: String, normal: String) -> NSMutableAttributedString {
        
        let attributsBold = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)]
        let attributsNormal = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .regular)]
        let attributedString = NSMutableAttributedString(string: bolt, attributes: attributsBold)
        let normalStringPart = NSMutableAttributedString(string: normal, attributes: attributsNormal)
        attributedString.append(normalStringPart)
        
        return attributedString
    }
    
    private func configure() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        view.addSubview(nameLabel)
        
        speciesLabel = UILabel()
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.textColor = .white
        view.addSubview(speciesLabel)
        
        genderLabel = UILabel()
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.textColor = .white
        view.addSubview(genderLabel)
        
        episodeCountLabel = UILabel()
        episodeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeCountLabel.textColor = .white
        view.addSubview(episodeCountLabel)
        
        statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .white
        view.addSubview(statusLabel)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textColor = .white
        view.addSubview(locationLabel)
        
        let guide = view.safeAreaLayoutGuide
        let spacing = CGFloat(16)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: spacing / 2),
            imageView.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            imageView.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            nameLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            nameLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: spacing),
            speciesLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            speciesLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: spacing),
            genderLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            genderLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            episodeCountLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: spacing),
            episodeCountLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            episodeCountLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            statusLabel.topAnchor.constraint(equalTo: episodeCountLabel.bottomAnchor, constant: spacing),
            statusLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            statusLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            locationLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: spacing),
            locationLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            locationLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing)
        ])
//        loadImage()
    }
    
    private func loadImage() {
        guard let url = URL(string: characterModel?.image ?? "") else { return }
        imageView.kf.indicatorType = .activity
        KF.url(url)
            .fade(duration: 1)
            .set(to: imageView)
    }
    
    private func configureActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .white
        view.addSubview(activityIndicatorView)
    }
    
    private func createAlertView() {
        let allert = UIAlertController.init(title: "Сбой загрузки!", message: "Проверьте подключение к интернету", preferredStyle: .alert)
        let reloadAction = UIAlertAction(title: "Обновить", style: .default) { _ in
            self.loadCharacter()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }

        allert.addAction(reloadAction)
        allert.addAction(cancelAction)
        present(allert, animated: true, completion: nil)
    }
}
