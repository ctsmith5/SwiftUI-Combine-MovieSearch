//
//  MovieDetailViewModel.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation



class MovieDetailViewModel: ObservableObject {
    
    var movie: Movie
    
    @Published var image: Data?
    

    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchImage() async {
        let apiClient = APIClient()
        let image = try! await apiClient.fetchImage(for: movie)
        self.image = image
    }
}
