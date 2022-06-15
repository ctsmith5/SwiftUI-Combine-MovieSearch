//
//  MovieListViewModel.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation


class MovieListViewModel: ObservableObject {
    
    @Published var movieList: [Movie] = []
    
    
    
    func fetchMovies(searchTerm: String, page: Int?) {
        let apiClient = APIClient()
        apiClient.fetchMovies(searchTerm: searchTerm)
        
       
    }
}
