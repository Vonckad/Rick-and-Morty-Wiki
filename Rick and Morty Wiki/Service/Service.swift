//
//  Service.swift
//  Rick and Morty Wiki
//
//  Created by Vlad Ralovich on 16.04.22.
//

import Foundation

protocol ServiceProtocol {
    func request(page: String, searchItem: String?, complition: @escaping (Data?, Error?) -> ())
}

class Service: ServiceProtocol {
    
    func request(page: String, searchItem: String?, complition: @escaping (Data?, Error?) -> ()) {
        let url = url(page: page, id: searchItem ?? "")
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
    
    private func url(page: String, id: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        if id != "" {
            components.path = "/api/character/\(id)"
        } else {
            components.path = "/api/character"
            components.queryItems?.append(URLQueryItem(name: "page", value: page))
        }
        return components.url!
    }
}
