//
//  ViewController.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 16.04.22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    private var serviceFetcher: ServiceFetcherProtocol = ServiceFetcher()
    private var charactersCollectionView: UICollectionView!
    private var activityIndicatorView = UIActivityIndicatorView(style: .large)
    private var currentPage = 1
    private var totalPage = 1
    private var characters: ModelCharacters? {
        didSet {
            charactersCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        title = "Rick and Morty Wiki"
        self.navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font : UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.backgroundColor = .brown
        navigationItem.backButtonTitle = "back"
        configureCollectionVIew()
        configureActivityIndicatorView()
        loadCharacters(page: "1")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.layer.position = view.center
    }
    
    private func loadCharacters(page: String) {
        activityIndicatorView.startAnimating()
        serviceFetcher.fetchAllCharacters(page: page) { modelCharacters in
            if modelCharacters == nil {
                self.createAlertView()
            }
            self.activityIndicatorView.stopAnimating()
            self.totalPage = modelCharacters?.info.pages ?? 1
            self.characters = modelCharacters
        }
    }
    
    private func configureCollectionVIew() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.frame.size.width - 64, height: view.frame.size.height / 3)
        flowLayout.minimumLineSpacing = 12
        charactersCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        view.addSubview(charactersCollectionView)
        charactersCollectionView.backgroundColor = .clear
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        charactersCollectionView.showsHorizontalScrollIndicator = false
        charactersCollectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
    }
    
    private func configureActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .white
        view.addSubview(activityIndicatorView)
    }
    
    private func createAlertView() {
        let allert = UIAlertController.init(title: "???????? ????????????????!", message: "?????????????????? ?????????????????????? ?? ??????????????????", preferredStyle: .alert)
        let reloadAction = UIAlertAction(title: "????????????????", style: .default) { _ in
            self.loadCharacters(page: String(self.currentPage))
        }

        allert.addAction(reloadAction)
        present(allert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        guard let model = characters?.results else { return cell }
        
        if currentPage < totalPage && indexPath.row == model.count - 1 {
            cell.backgroundColor = .clear
            cell.hiddenAll(true)
            return cell
        }else {
            cell.hiddenAll(false)
            cell.nameLabel.text = model[indexPath.row].name
            cell.genderLabel.text = model[indexPath.row].gender
            cell.speciesLabel.text = model[indexPath.row].species
            cell.imageView.kf.indicatorType = .activity
            guard let urlImage = URL(string: model[indexPath.row].image) else { return cell }
            KF.url(urlImage)
                .fade(duration: 1)
                .set(to: cell.imageView)
            cell.backgroundColor = .gray
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let model = characters?.results else { return }
        if currentPage < totalPage && indexPath.row == model.count - 1 {
            currentPage = currentPage + 1
            serviceFetcher.fetchAllCharacters(page: String(currentPage)) { modelCharacters in
                guard let modelCharacters = modelCharacters else { return }
                self.characters?.results.append(contentsOf: modelCharacters.results)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(id: characters?.results[indexPath.row].id ?? 0)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
