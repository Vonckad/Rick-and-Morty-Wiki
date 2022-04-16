//
//  ServiceFetcher.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 16.04.22.
//

import Foundation

protocol ServiceFetcherProtocol {
    func fetchCharactersById(searchItem: String?, complition: @escaping (ResultsCharacters?) -> Void)
    func fetchAllCharacters(complition: @escaping (ModelCharacters?) -> Void)
}

class ServiceFetcher: ServiceFetcherProtocol {
    var service: ServiceProtocol = Service()
    
    func fetchCharactersById(searchItem: String?, complition: @escaping (ResultsCharacters?) -> Void) {
        service.request(searchItem: searchItem) { data, error in
            if let error = error {
                print("error request = \(error.localizedDescription )")
                complition(nil)
            }
            let decod = self.decodJSON(type: ResultsCharacters.self, from: data)
            complition(decod)
        }
    }
    
    func fetchAllCharacters(complition: @escaping (ModelCharacters?) -> Void) {
        service.request(searchItem: nil) { data, error in
            if let error = error {
                print("error request = \(error.localizedDescription )")
                complition(nil)
            }
            let decod = self.decodJSON(type: ModelCharacters.self, from: data)
            complition(decod)
        }
    }
    
    private func decodJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch let jsonError {
            print("jsonError = \(jsonError)")
            return nil
        }
    }
}
