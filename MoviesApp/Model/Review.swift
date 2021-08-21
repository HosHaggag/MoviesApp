//
//  Review.swift
//  MoviesApp
//
//  Created by Hossam on 20/08/2021.
//

import Foundation


struct ReviewResults : Decodable{
    
    let results: [Review]
}



struct Review : Decodable{
    let content: String
    
    enum CodingKeys: String, CodingKey {

      case content = "content"
    }
    
    
    
}
