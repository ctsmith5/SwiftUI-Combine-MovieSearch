//
//  MovieListViewModel.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation


class MovieListViewModel: ObservableObject {
    
    @Published var movieList: [Movie] = []
    
    
    
    func fetchMovies(searchTerm: String, page: Int?) async {
        let apiClient = APIClient()
        let movies = await apiClient.fetchMovies(searchTerm: searchTerm)
        self.movieList = movies
    }
}
