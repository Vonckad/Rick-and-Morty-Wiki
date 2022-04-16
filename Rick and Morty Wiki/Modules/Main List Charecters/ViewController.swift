//
//  ViewController.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 16.04.22.
//

import UIKit

class ViewController: UIViewController {
    private var serviceFetcher: ServiceFetcherProtocol = ServiceFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        serviceFetcher.fetchAllCharacters { modelCharacters in
            print(modelCharacters?.results.count)
        }
        serviceFetcher.fetchCharactersById(searchItem: "1") { resultsCharacters in
            print(resultsCharacters)
        }
    }


}

