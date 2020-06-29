//
//  ListTableViewController.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class ListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageLoadingView: UIView!
    @IBOutlet weak var pageLoadingIndicator: UIActivityIndicatorView!
    
    var delegate:ListTableProtocol?
    var movies:Array<Movie>?
    var lastFetchedPage = 1
    
    lazy var refreshControl: UIRefreshControl =
    {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:#selector(ListTableViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.register(UINib(nibName:"MovieTableViewCell", bundle: nil), forCellReuseIdentifier:"MovieTableViewCell")

        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.prefetchDataSource = self
        
        self.tableView.addSubview(self.refreshControl)
    }

    func loadUIFromData(movies:Array<Movie>?)
    {
        self.movies = movies
        
        refreshUI()
    }
    
    func refreshUI()
    {
        if let tableview = self.tableView
        {
            tableview.reloadData()
        }
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if let count = self.movies?.count
        {
            return count
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell

        if let movies = self.movies
        {
            let movie = movies[indexPath.row]
            
            cell.loadData(movie,delegate:self)
        }
        
        checkAndLoadNextPage(indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let controller = self.storyboard?.instantiateViewController(identifier:"MovieDetailViewController") as? MovieDetailViewController, let movies = self.movies
        {
            let movie = movies[indexPath.row]

            controller.movie = movie
            
            self.navigationController?.pushViewController(controller, animated:true)
        }
    }
}

extension ListTableViewController:TableCellProtocol
{
    func movieFavoriteTpped(movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        if let delegate = self.delegate
        {
            delegate.movieFavoriteTpped(movie:movie, success:success, failure:failure)
        }
    }
}

extension ListTableViewController:UITableViewDataSourcePrefetching
{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])
    {
    }
    
    func checkAndLoadNextPage(_ cellNumber:Int)
    {
        if let count = self.movies?.count, count <= 0 || cellNumber >= count-1
        {
            let currentlyTotalLoadedPage =  count / PER_PAGE_ITEMS;
            
            let nextPageToLoad = currentlyTotalLoadedPage + 1
            
            if lastFetchedPage != nextPageToLoad, let delegate = self.delegate
            {
                updateVisibilityOfPageLoadingIndicator(shouldVisible:true)
                
                delegate.loadPageData(page:nextPageToLoad, success: { (movies:Array<Movie>) in
                
                    DispatchQueue.main.async
                    {
                        SpinnyIndicator.hideSpinny()
                        
                        self.lastFetchedPage = nextPageToLoad
                        
                        self.movies?.append(contentsOf:movies)
                        
                        self.updateVisibilityOfPageLoadingIndicator(shouldVisible:false)
                        
                        self.refreshUI()
                    }
                })
                { (error:Error?) in
                
                    self.updateVisibilityOfPageLoadingIndicator(shouldVisible:false)
                }
            }
        }
    }
}

extension ListTableViewController
{
    @objc func handleRefresh(_ refreshControl: UIRefreshControl)
    {
        if let delegate = self.delegate
        {
            SpinnyIndicator.showSpinny()
            
            delegate.refreshData(success: { (movies:Array<Movie>) in
                
                DispatchQueue.main.async
                {
                    self.tableView.reloadData()
                    
                    refreshControl.endRefreshing()
                    
                    SpinnyIndicator.hideSpinny()
                }
            }) { (error:Error?) in }
        }
    }
}

extension ListTableViewController
{
    func updateVisibilityOfPageLoadingIndicator(shouldVisible:Bool)
    {
        pageLoadingView.isHidden = !shouldVisible
        
        if shouldVisible
        {
            pageLoadingIndicator.startAnimating()
        }
        else
        {
            pageLoadingIndicator.stopAnimating()
        }
    }
}
