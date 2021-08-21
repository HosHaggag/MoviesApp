//
//  Movies.swift
//  MoviesApp
//
//  Created by Hossam on 10/08/2021.
//

import Foundation
import UIKit

struct PopularMovieResult: Decodable {
 
  let results: [Movie]
  
}



struct Movie: Decodable {
  let name: String
  let description: String
  let voteCount: Int
  let voteAverage: Double
  let poster: String?
  let date: String?
    let id : Int
  
  enum CodingKeys: String, CodingKey {
    case name = "title"
    case description = "overview"
    case voteCount = "vote_count"
    case voteAverage = "vote_average"
    case poster = "poster_path"
    case date = "release_date"
    case id = "id"
  }
}
