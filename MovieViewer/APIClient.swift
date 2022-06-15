//
//  APIClient.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation


class APIClient: ObservableObject {
    
    static let apiKey = "6e6b1cb140fbaee2fe4a98f1ec253860"
    
    
    func fetchMovies(searchTerm: String, page: Int = 1, allowMatureResults explicit: Bool = false) {
        guard !searchTerm.isEmpty,
              var url = URL(string: "https://api.themoviedb.org/3/search/movie") else { return }
       
        
    }
    
    func fetchImage(for movie: Movie) {
        guard var urlString = URL(string: "https://image.tmdb.org/t/p/w500/") else { return }

        
    }
    
}
