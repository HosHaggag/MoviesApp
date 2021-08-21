//
//  ConnectionHandler.swift
//  MoviesApp
//
//  Created by Hossam on 10/08/2021.
//

import Foundation
import UIKit
import Alamofire

class Service {
  
    
    func fetchDataFromApiByAlamofire(completion :@escaping ([Movie]?,String?)->Void){
        
        
        
        
        
        let url = URL(string: "\(Const.link)/movie/popular?language=en-US&api_key=\(Const.apiKey)" )
  
        
       
        let request = AF.request(url!,method: .get,encoding: JSONEncoding.default)
        
  
        request.responseJSON { (dataResponse) in
            
            
            if let data = dataResponse.data {
                
                
              let jsonDecoder = JSONDecoder()
                if let decodedObj = try?jsonDecoder.decode(PopularMovieResult.self, from: data){
                    
                    
                    completion(decodedObj.results , nil)
                    
                    
                }
                
            }
            
            
            if let error = dataResponse.error {
                
                
                completion(nil , error.localizedDescription)
                
            }
     
        }
     
        
    }
    
    
    func fetchReviewsData( id: Int ,completion :@escaping ([Review]?,String?)->Void){
        
        
        
        
        
        let url = URL(string: "\(Const.link)/movie/\(id)/reviews?api_key=\(Const.apiKey)" )
  
              
        let request = AF.request(url!,method: .get,encoding: JSONEncoding.default)
        
  
        request.responseJSON { (dataResponse) in
            
            
            if let data = dataResponse.data {
                
                
              let jsonDecoder = JSONDecoder()
                if let decodedObj = try?jsonDecoder.decode(ReviewResults.self, from: data){
                    
                    
                    completion(decodedObj.results , nil)
                    
                    
                }
                
            }
            
            
            if let error = dataResponse.error {
                
                
                completion(nil , error.localizedDescription)
                
            }
     
        }
     
        
    }
    
    
    
    func fetchVideosData( id : Int, completion :@escaping ([Trailer]?,String?)->Void){
        
        
        
        
        
        let url = URL(string: "\(Const.link)/movie/\(id)/videos?api_key=\(Const.apiKey)" )
  
        
        let request = AF.request(url!,method: .get,encoding: JSONEncoding.default)
        
  
        request.responseJSON { (dataResponse) in
            
            
            if let data = dataResponse.data {
                
                
              let jsonDecoder = JSONDecoder()
                if let decodedObj = try?jsonDecoder.decode(TeailersMovieResult.self, from: data){
                    
                    
                    completion(decodedObj.results , nil)
                    
                    
                }
                
            }
            
            
            if let error = dataResponse.error {
                
                
                completion(nil , error.localizedDescription)
                
            }
     
        }
     
        
    }
    
    
    
}
