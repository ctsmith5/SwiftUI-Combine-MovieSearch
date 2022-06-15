//
//  APIClient.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation


class APIClient: ObservableObject {
    
    static let apiKey = "6e6b1cb140fbaee2fe4a98f1ec253860"
    
    
    func fetchMovies(searchTerm: String, page: Int = 1, allowMatureResults explicit: Bool = false) async -> [Movie] {
        guard !searchTerm.isEmpty,
              var urlString = URL(string: "https://api.themoviedb.org/3/search/movie") else { return [Movie]() }
        urlString.append(queryItems: [
                    URLQueryItem(name: "api_key", value: APIClient.apiKey),
                    URLQueryItem(name: "query", value: searchTerm),
                    URLQueryItem(name: "include_adult", value: "\(explicit)"),
                ])

        let (data, response) = try! await URLSession.shared.data(from: urlString)
        let decoder = JSONDecoder()
        let movieResponse = try! decoder.decode(MovieResponse.self, from: data)
        
        print(response)
        return movieResponse.results
        
    }
    
    func fetchImage(for movie: Movie) async  -> Data {
        guard var urlString = URL(string: "https://image.tmdb.org/t/p/w500/") else { return Data() }
        
        if let thumbnail = movie.thumbnail {
            urlString.appendPathComponent(thumbnail)
        }
        
        let (data, response) = try! await URLSession.shared.data(from: urlString)
        print(response)
        return data
    }
    
}
