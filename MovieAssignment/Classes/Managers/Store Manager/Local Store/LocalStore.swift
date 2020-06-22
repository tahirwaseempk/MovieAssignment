//
//  LocalStore.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class LocalStore: StoreProtocol
{
    static func getAllMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        let (movies,error) = Movie.getAllMovies()
        
        if let movies = movies
        {
            success(movies)
        }
        else if error != nil
        {
            failure(error)
        }
        else
        {
            success(Array<Movie>())
        }
    }
    
    static func saveToFavorite(_ movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
    
    static func saveMovies(moviesJson:Dictionary<String,Any>, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        if let movies = MovieParser.init().parse(moviesJson) as? Array<Movie>
        {
            if let error = Movie.saveMovies(movies:movies)
            {
                failure(error)
            }
            else
            {
                success()
            }
        }
        else
        {
            failure(nil)
        }
    }
    
    static func saveMovies(movies:Array<Movie>, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        if let error = Movie.saveMovies(movies:movies)
        {
            failure(error)
        }
        else
        {
            success()
        }
    }
    
    static func saveMovie(movies:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        if let error = movies.saveMovie()
        {
            failure(error)
        }
        else
        {
            success()
        }
    }
    
    static func getAllFavoriteMovies(success:@escaping(_ movies:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        let movies = Movie.getAllFavoriteMovies()
        
        if let movies = movies
        {
            success(movies)
        }
        else
        {
            success(Array<Movie>())
        }
    }
    
    
    static func getAllSuggestions() -> Array<String>
    {
        let userDefaults = UserDefaults.standard
        
        if let suggestions = userDefaults.object(forKey:"suggestions") as? Array<String>
        {
            return suggestions
        }
        
        return Array<String>()
    }
    
    @discardableResult
    static func saveSuggestion(_ suggestion:String) -> Bool
    {
        let userDefaults = UserDefaults.standard
           
        if let suggestions = userDefaults.value(forKey:"suggestions") as? Array<String>
        {
            var mutableCopy = suggestions
            
            if !mutableCopy.contains(suggestion)
            {
                mutableCopy.insert(suggestion, at:0)
                
                if mutableCopy.count > 10
                {
                    mutableCopy.removeLast()
                }
                
                userDefaults.setValue(mutableCopy, forKey: "suggestions")
                
                return userDefaults.synchronize()
            }
            
            return false
        }
        
        var mutableCopy = Array<String>()
        
        mutableCopy.append(suggestion)
        
        userDefaults.setValue(mutableCopy, forKey: "suggestions")
        
        return userDefaults.synchronize()
    }
}
