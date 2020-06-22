//
//  SearchViewController.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var suggestionContainerView: UIView!
    var moviesListController:ListTableViewController!
    var suggestionViewController:SuggestionViewController!
    var movies:Array<Movie>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        suggestionContainerView.isHidden = true

        searchBar.delegate = self
    }
    
    func reloadData()
    {
        if let moviesListController = self.moviesListController
        {
            moviesListController.loadUIFromData(movies:self.movies)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ListTableViewController" {
            if let moviesListController = segue.destination as? ListTableViewController {
                self.moviesListController = moviesListController
                moviesListController.loadUIFromData(movies:self.movies)
                moviesListController.delegate = self
            }
        }
        else if segue.identifier == "SuggestionViewController" {
            if let suggestionViewController = segue.destination as? SuggestionViewController {
                self.suggestionViewController = suggestionViewController
                suggestionViewController.delegate = self
            }
        }
    }
}

extension SearchViewController:ListTableProtocol
{
    func searchMovieName(_ movieName:String, page:Int)
    {
        SpinnyIndicator.showSpinny()
        
        StoreManager.searchMovies(movieName, page:page, success: { (movies:Array<Movie>) in
            
            DispatchQueue.main.async
            {
                self.movies = movies
                                
                self.searchBar.text = movieName
                
                self.reloadData()
                
                if (movies.count <= 0)
                {
                    let alertController = UIAlertController(title: "Alert", message: "No Movie Found", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                    }
                    
                    alertController.addAction(action)

                    self.present(alertController, animated: true, completion: nil)
                }
                else
                {
                    if let suggestionViewController = self.suggestionViewController
                    {
                        suggestionViewController.addSuggestion(movieName)
                    }
                }
                
                SpinnyIndicator.hideSpinny()
            }
        }) { (error:Error?) in
            
            DispatchQueue.main.async
            {
                SpinnyIndicator.hideSpinny()

                let alertController = UIAlertController(title:"Error!", message:error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func loadPageData(page:Int, success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        success(self.movies ?? Array<Movie>())
    }

    func loadData(success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        success(self.movies ?? Array<Movie>())
    }
    
    func movieFavoriteTpped(movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        success()
    }
}

extension SearchViewController:UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        if let suggestionViewController = self.suggestionViewController
        {
            suggestionViewController.reloadSuggestions()
        }
        
        suggestionContainerView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        suggestionContainerView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        
        suggestionContainerView.isHidden = true

        if let count = searchBar.text?.count, count > 0
        {
            self.searchMovieName(searchBar.text!,page:1)
        }
        else
        {
            self.movies?.removeAll()
            
            self.reloadData()
        }
    }
}

extension SearchViewController:SuggestionViewProtocol
{
    func suggestionTapped(_ suggestionText:String)
    {
        suggestionContainerView.isHidden = true

        searchBar.resignFirstResponder()

        self.searchMovieName(suggestionText,page:1)
    }
}
