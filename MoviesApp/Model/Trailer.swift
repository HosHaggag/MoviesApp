//
//  Trailer.swift
//  MoviesApp
//
//  Created by Hossam on 20/08/2021.
//

import Foundation


struct TeailersMovieResult: Decodable {
 
  let results: [Trailer]
  
}


struct Trailer : Decodable{
    
    
    
    let key: String
    enum CodingKeys: String, CodingKey {
      case key = "key"
   
    }

    
    
    
    
}
