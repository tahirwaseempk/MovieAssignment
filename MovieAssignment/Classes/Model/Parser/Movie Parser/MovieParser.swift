//
//  MovieParser.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import Foundation
import CoreData

class MovieParser:Parser
{
    func parse(_ json:Dictionary<String,Any>) -> Any?
    {
        var movies = Array<Movie>()

        if let moviesArray = json["results"] as? Array<Dictionary<String,Any>>
        {
            for movieJson in moviesArray
            {
                if let movieId = movieJson["id"] as? Int64
                {
                    if let movie = Movie.findMovieById(movieId)
                    {
                        movie.updateFromJSON(movieJson)

                        movies.append(movie)
                    }
                    else
                    {
                        let movie = Movie.initWithJSON(movieJson)
                        
                        movies.append(movie)
                    }
                }
            }
        }
        
        return movies
    }
}

extension Movie
{
    static func initWithJSON(_ json:Dictionary<String,Any>) -> Movie
    {
        let entity = NSEntityDescription.entity(forEntityName:"Movie", in:MANAGED_OBJECT_CONTEXT_MAIN)!
        
        let movie:Movie = NSManagedObject(entity:entity, insertInto:MANAGED_OBJECT_CONTEXT_MAIN) as! Movie
                
        if let id = json["id"] as? Int64
        {
            movie.movieId = id
        }
        
        movie.updateFromJSON(json)

        return movie
    }
    
    func updateFromJSON(_ json:Dictionary<String,Any>)
    {
        if let movieTitle = json["title"] as? String
        {
            self.movieTitle = movieTitle
        }

        if let movieReleaseDate = json["release_date"] as? String
        {
            self.movieReleaseDate = movieReleaseDate
        }

        if let movieContents = json["overview"] as? String
        {
            self.movieContents = movieContents
        }

        if let movieBannerUrl = json["poster_path"] as? String
        {
            self.movieLogoUrl = "https://image.tmdb.org/t/p/w92/" + movieBannerUrl
        }

        if let movieLogoUrl = json["backdrop_path"] as? String
        {
            self.movieBannerUrl = "https://image.tmdb.org/t/p/w92/" + movieLogoUrl
        }
    }
}
