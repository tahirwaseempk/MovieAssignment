//
//  FavoriteMoviesViewController.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {

    var moviesListController:ListTableViewController?
    var movies:Array<Movie>?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ListTableViewController" {
            if let moviesListController = segue.destination as? ListTableViewController {
                self.moviesListController = moviesListController
                moviesListController.delegate = self
            }
        }
    }
    
    func reloadData(success:@escaping(_ succeeded:Bool) -> Void)
    {
        StoreManager.getAllFavoriteMovies(success: { (movies:Array<Movie>) in
            
            DispatchQueue.main.async
            {
                self.movies = movies

                if let moviesListController = self.moviesListController
                {
                    moviesListController.loadUIFromData(movies:self.movies)
                }
                
                success(true)
            }
        }) { (error:Error?) in
                success(false)
        }
    }
}

extension FavoriteMoviesViewController:ListTableProtocol
{
    func loadPageData(page:Int, success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }

    func refreshData(success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        reloadData{(succeeded:Bool)in
            
            success(self.movies ?? Array<Movie>())
        }
    }

    func movieFavoriteTpped(movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        reloadData{(succeeded:Bool)in success() }
    }
}
