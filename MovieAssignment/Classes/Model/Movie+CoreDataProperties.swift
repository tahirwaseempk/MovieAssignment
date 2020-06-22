//
//  Movie+CoreDataProperties.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//
//

import Foundation
import CoreData

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var movieId: Int64
    @NSManaged public var movieBannerUrl: String?
    @NSManaged public var movieLogoUrl: String?
    @NSManaged public var movieTitle: String?
    @NSManaged public var isMovieFavorite: Bool
    @NSManaged public var movieReleaseDate: String?
    @NSManaged public var movieContents: String?
}

extension Movie
{
    static func saveMovies(movies:Array<Movie>) -> Error?
    {
        do
        {
            try MANAGED_OBJECT_CONTEXT_MAIN.save()
            
            return nil

        } catch let error
        {
            return error
        }
    }
    
    func saveMovie() -> Error?
    {
        do
        {
            try self.managedObjectContext?.save()
            
            return nil

        } catch let error
        {
            return error
        }
    }
    
    static func getAllMovies() -> (Array<Movie>?, Error?)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Movie")
        
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do
        {
            if let result = try MANAGED_OBJECT_CONTEXT_MAIN.fetch(request) as? Array<Movie>
            {
                return (result,nil)
            }
            else
            {
                return (nil,nil)
            }
            
        } catch let error
        {
            return (nil,error)
        }
    }
    
    static func findMovieById(_ movieId:Int64) -> (Movie?)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Movie")
        
        request.predicate = NSPredicate(format: "movieId = %i",movieId)
        
        request.returnsObjectsAsFaults = false
        do
        {
            if let result = try MANAGED_OBJECT_CONTEXT_MAIN.fetch(request) as? Array<Movie>, result.count > 0
            {
                return result.first
            }
            else
            {
                return nil
            }
            
        } catch
        {
            return nil
        }
    }
    
    static func getAllFavoriteMovies() -> Array<Movie>?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Movie")
        
        request.predicate = NSPredicate(format: "isMovieFavorite = true")
        
        request.returnsObjectsAsFaults = false
        do
        {
            if let result = try MANAGED_OBJECT_CONTEXT_MAIN.fetch(request) as? Array<Movie>, result.count > 0
            {
                return result
            }
            else
            {
                return nil
            }
            
        } catch
        {
            return nil
        }
    }

}
