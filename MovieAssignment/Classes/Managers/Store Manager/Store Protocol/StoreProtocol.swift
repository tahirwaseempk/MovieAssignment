//
//  StoreProtocol.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import Foundation

protocol StoreProtocol
{
    static func syncMoviesFromServer(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)

    static func getAllMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    
    static func getAllMovies(success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)

    static func saveToFavorite(_ movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    
    static func saveMovies(moviesJson:Dictionary<String,Any>, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)

    static func saveMovies(movies:Array<Movie>, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    
    static func saveMovie(movies:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    
    static func getAllFavoriteMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    
    static func searchMovies(_ moviesName:String, page:Int, success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
}

extension StoreProtocol
{
    static func syncMoviesFromServer(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
    
    static func getAllMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
    
    static func getAllMovies(success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }

    static func saveToFavorite(_ movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }

    static func saveMovies(moviesJson:Dictionary<String,Any>, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }

    static func saveMovies(movies:Array<Movie>, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }

    static func saveMovie(movies:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
    
    static func getAllFavoriteMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
    
    static func searchMovies(_ moviesName:String, page:Int, success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
}
