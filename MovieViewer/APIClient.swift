//
//  APIClient.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation
import Combine

class APIClient: ObservableObject {
    
    static let apiKey = "6e6b1cb140fbaee2fe4a98f1ec253860"
    
    var movieListPublisher: AnyPublisher<MovieResponse, Error>?
    var movieImagePublisher: AnyPublisher<Data,Error>?
    
    func fetchMovies(searchTerm: String, page: Int = 1, allowMatureResults explicit: Bool = false) {
        guard !searchTerm.isEmpty else { return }
        guard var url = URL(string: "https://api.themoviedb.org/3/search/movie") else { return }
        url.append(queryItems: [
            URLQueryItem(name: "api_key", value: APIClient.apiKey),
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "include_adult", value: "\(explicit)"),
        ])
        
        movieListPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    func fetchImage(for movie: Movie) {
        guard var urlString = URL(string: "https://image.tmdb.org/t/p/w500/") else { return }
        if let thumbnail = movie.thumbnail {
            urlString.appendPathComponent(thumbnail)
            movieImagePublisher = URLSession.shared.dataTaskPublisher(for: urlString)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
    }
    
}
