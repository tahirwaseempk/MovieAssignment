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
    
    func reloadData()
    {
        StoreManager.getAllFavoriteMovies(success: { (movies:Array<Movie>) in
            
            DispatchQueue.main.async
            {
                self.movies = movies

                if let moviesListController = self.moviesListController
                {
                    moviesListController.loadUIFromData(movies:self.movies)
                }
            }
        }) { (error:Error?) in
                
        }
    }
}

extension FavoriteMoviesViewController:ListTableProtocol
{
    func movieFavoriteTpped(movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        reloadData()
    }
}
