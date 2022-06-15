//
//  MovieListViewModel.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var movieList: [Movie] = []
    
    var subscriber: AnyCancellable?
    
    
    func fetchMovies(searchTerm: String, page: Int?) {
        let apiClient = APIClient()
        apiClient.fetchMovies(searchTerm: searchTerm)
        
        subscriber = apiClient.movieListPublisher?.sink(receiveCompletion: {
            print ("Received completion: \($0).")
        }, receiveValue: { movieResponse in
            self.movieList = movieResponse.results
        })
    }
}
