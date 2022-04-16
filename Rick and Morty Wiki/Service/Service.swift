//
//  Service.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 16.04.22.
//

import Foundation

protocol ServiceProtocol {
    func request(searchItem: String?, complition: @escaping (Data?, Error?) -> ())
}

class Service: ServiceProtocol {
    
    func request(searchItem: String?, complition: @escaping (Data?, Error?) -> ()) {
        let url = url(id: searchItem ?? "")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let dataTask = createDataTask(from: urlRequest, complition: complition)
        dataTask.resume()
        print("url = \(url)")
    }
    
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }
    
    private func url(id: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = id != "" ? "/api/character/\(id)" : "/api/character"
        return components.url!
    }
}
