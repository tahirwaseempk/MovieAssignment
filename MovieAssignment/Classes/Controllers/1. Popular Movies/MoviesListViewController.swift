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
        
        reloadData()
    }
    
    func reloadData()
    {
        StoreManager.getAllMovies(success: { (movies:Array<Movie>) in
            
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
    
    @IBAction func segmentControl_ValueChanged(_ segment:UISegmentedControl)
    {
        self.scrollView.scrollTo(horizontalPage:self.segmentControl.selectedSegmentIndex, animated:true)
        
        if segment.selectedSegmentIndex == 0
        {
            self.reloadData()
        }
        else if segment.selectedSegmentIndex == 1, let favoriteMoviesViewController = self.favoriteMoviesViewController
        {
            favoriteMoviesViewController.reloadData()
        }
        else if segment.selectedSegmentIndex == 2, let searchViewController = self.favoriteMoviesViewController
        {
            searchViewController.reloadData()
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
            }
        }
    }
}
