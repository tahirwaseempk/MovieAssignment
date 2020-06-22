//
//  SuggestionViewController.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    var delegate:SuggestionViewProtocol?
    var datasource:SuggestionTableDatasource!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        datasource = SuggestionTableDatasource(suggestionsList:LocalStore.getAllSuggestions(), delegate:self.delegate!)
        
        tableView.delegate = datasource
        tableView.dataSource = datasource
    }
    
    func addSuggestion(_ suggestion:String)
    {
        LocalStore.saveSuggestion(suggestion)
        
        self.reloadSuggestions()
    }
        
    func reloadSuggestions()
    {
        datasource.reloadFromList(suggestionsList:LocalStore.getAllSuggestions())
        
        tableView.reloadData()
    }
}
