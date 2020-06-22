//
//  StoreManager.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class StoreManager:NSObject
{
    static func syncMoviesFromServer(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        RemoteStore.getAllMovies(success:{(movies:Dictionary<String, Any>) in
            
            LocalStore.saveMovies(moviesJson:movies, success: {
                
                LocalStore.getAllMovies(success:success, failure:failure)
                
            }, failure:failure)
            
        }, failure: failure)
    }

    static func getAllMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        RemoteStore.getAllMovies(success:{(movies:Dictionary<String, Any>) in
            
            LocalStore.saveMovies(moviesJson:movies, success: {
                
                LocalStore.getAllMovies(success:success, failure:failure)

            }) { (error:Error?) in
                
                LocalStore.getAllMovies(success:success, failure:failure)
            }
        }) { (error:Error?) in
            
            LocalStore.getAllMovies(success:success, failure:failure)
        }
    }
    
    static func saveToFavorite(_ movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        LocalStore.saveToFavorite(movie, success:success, failure:failure)
    }
    
    static func getAllFavoriteMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        LocalStore.getAllFavoriteMovies(success:success, failure:failure)
    }
    
    static func searchMovies(_ moviesName:String, page:Int, success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        RemoteStore.searchMovies(moviesName, page:page, success: {(moviesJson:Dictionary<String, Any>) in
            
            if let movies = MovieParser.init().parse(moviesJson) as? Array<Movie>
            {
                success(movies)
            }
            else
            {
                failure(nil)
            }
        }, failure:failure)
    }
}
