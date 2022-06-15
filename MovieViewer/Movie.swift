//
//  Movie.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import Foundation


struct Movie: Identifiable, Decodable {
    var thumbnail: String?
    var id: Int?
    var description: String?
    var releaseDate: String?
    var name: String
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case thumbnail = "backdrop_path"
        case id = "id"
        case description = "overview"
        case releaseDate = "release_date"
        case name = "title"
        case rating = "vote_average"
    }
    
    /*
     adult: false,
     backdrop_path: "/jBFxXKCrViA88hhO59fDx0Av4P.jpg",
     genre_ids: [
     12,
     28,
     878
     ],
     id: 11,
     original_language: "en",
     original_title: "Star Wars",
     overview: "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.",
     popularity: 106.689,
     poster_path: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
     release_date: "1977-05-25",
     title: "Star Wars",
     video: false,
     vote_average: 8.2,
     vote_count: 17318
     
     */
    
    
    
}


struct MovieResponse: Decodable {
    var results: [Movie]
}
