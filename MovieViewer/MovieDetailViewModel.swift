//
//  MovieDetailViewModel.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation
import Combine


class MovieDetailViewModel: ObservableObject {
    
    var movie: Movie
    
    @Published var image: Data?
    
    var movieImageSubscriber: AnyCancellable?

    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchImage() {
        let apiClient = APIClient()
        apiClient.fetchImage(for: movie)
        movieImageSubscriber = apiClient.movieImagePublisher?.sink(receiveCompletion: {
            print("================================================================")
            print("IMAGE DATA FOR MOVIE: \(self.movie.name) STATUS: \($0)")
        }, receiveValue: { imageData in
            self.image = imageData
        })
    }
}
