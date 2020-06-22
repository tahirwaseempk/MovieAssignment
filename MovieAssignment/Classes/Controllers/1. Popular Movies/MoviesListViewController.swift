//
//  MoviesListViewController.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var movies:Array<Movie>?
    var moviesListController:ListTableViewController!
    var searchViewController:SearchViewController!
    var favoriteMoviesViewController:FavoriteMoviesViewController!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        reloadData{(success:Bool) in}
    }
    
    func reloadData(success:@escaping(_ succeeded:Bool) -> Void)
    {
        StoreManager.getAllMovies(success: { (movies:Array<Movie>) in
            
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
    
    @IBAction func segmentControl_ValueChanged(_ segment:UISegmentedControl)
    {
        self.scrollView.scrollTo(horizontalPage:self.segmentControl.selectedSegmentIndex, animated:true)
        
        if segment.selectedSegmentIndex == 0
        {
            reloadData{(success:Bool) in}
        }
        else if segment.selectedSegmentIndex == 1, let favoriteMoviesViewController = self.favoriteMoviesViewController
        {
            favoriteMoviesViewController.reloadData{(success:Bool) in}
        }
        else if segment.selectedSegmentIndex == 2, let searchViewController = self.favoriteMoviesViewController
        {
            searchViewController.reloadData{(success:Bool) in}
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "FavoriteMoviesViewController" {
            if let favoriteMoviesViewController = segue.destination as? FavoriteMoviesViewController {
                self.favoriteMoviesViewController = favoriteMoviesViewController
            }
        }
        else if segue.identifier == "SearchViewController" {
            if let searchViewController = segue.destination as? SearchViewController {
                self.searchViewController = searchViewController
            }
        }
        else if segue.identifier == "ListTableViewController" {
            if let moviesListController = segue.destination as? ListTableViewController {
                self.moviesListController = moviesListController
                moviesListController.delegate = self
            }
        }
    }
}

extension MoviesListViewController:ListTableProtocol
{
    func loadPageData(page:Int, success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
    
    func loadData(success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        reloadData{(succeeded:Bool)in
            
            success(self.movies ?? Array<Movie>())
        }
    }
    
    func movieFavoriteTpped(movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        
    }
}
