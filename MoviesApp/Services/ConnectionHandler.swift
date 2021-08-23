//
//  ConnectionHandler.swift
//  MoviesApp
//
//  Created by Hossam on 10/08/2021.
//

import Foundation
import UIKit
import Alamofire
import SystemConfiguration

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
    
    
    
    class func isConnectedToNetwork() -> Bool {

           var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
           zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
           zeroAddress.sin_family = sa_family_t(AF_INET)

           let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
               $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                   SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
               }
           }

           var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
           if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
               return false
           }

           /* Only Working for WIFI
           let isReachable = flags == .reachable
           let needsConnection = flags == .connectionRequired

           return isReachable && !needsConnection
           */

           // Working for Cellular and WIFI
           let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
           let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
           let ret = (isReachable && !needsConnection)

           return ret

       }
    
    
    
}
