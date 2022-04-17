//
//  ViewController.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 16.04.22.
//

import UIKit

class ViewController: UIViewController {
    private var serviceFetcher: ServiceFetcherProtocol = ServiceFetcher()
    private var characters: ModelCharacters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        serviceFetcher.fetchAllCharacters(page: "3") { modelCharacters in
            self.characters = modelCharacters
        }
    }


}

