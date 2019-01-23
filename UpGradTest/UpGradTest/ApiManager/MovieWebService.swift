//
//  MovieWebServiceHandler.swift
//  UpGradTest
//
//  Created by Mukesh Verma on 22/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import Foundation

enum MovieType {
    case Popular
    case HighRated
}

struct MovieWebService {
    
    func getPopularMovieList(movieType : MovieType, pageNum : Int ,completion: @escaping (MovieInfo?, _ error: Error?)->()) {
        
        var finalUrl : String
        
        switch movieType {
        case .Popular:
            finalUrl = "https://api.themoviedb.org/3/discover/movie?page=\(pageNum)&include_video=false&include_adult=false&sort_by=popularity.desc&language=en-US&api_key=\(AppConstants.imdbApiKey)"
        case .HighRated:
            finalUrl = "https://api.themoviedb.org/3/discover/movie?page=\(pageNum)&include_video=false&include_adult=false&sort_by=vote_average.desc&language=en-US&api_key=\(AppConstants.imdbApiKey)"
        }
        
        WebApiManager.sharedService.requestAPI(url: finalUrl, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(MovieInfo.self, from: data)
                completion(responseModel,nil)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
        }
    }
    
    func getPopularMovieList(pageNum : Int ,completion: @escaping (MovieInfo?, _ error: Error?)->()) {
        
        let finalUrl : String = "https://api.themoviedb.org/3/discover/movie?page=\(pageNum)&include_video=false&include_adult=false&sort_by=popularity.desc&language=en-US&api_key=\(AppConstants.imdbApiKey)"

        WebApiManager.sharedService.requestAPI(url: finalUrl, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(MovieInfo.self, from: data)
                completion(responseModel,nil)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
        }
    }
    
}
