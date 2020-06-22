//
//  SuggestionTableDatasource.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class SuggestionTableDatasource: NSObject
{
    var suggestionsList:Array<String>!
    var delegate:SuggestionViewProtocol?

    init(suggestionsList:Array<String>, delegate:SuggestionViewProtocol?)
    {
        super.init()
        
        self.suggestionsList = suggestionsList
        
        self.delegate = delegate
    }
    
    func reloadFromList(suggestionsList:Array<String>)
    {
        self.suggestionsList = suggestionsList
    }
}

extension SuggestionTableDatasource:UITableViewDataSource
{
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return suggestionsList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 25.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "CustomCell") as UITableViewCell?)!
        
        cell.textLabel?.text = suggestionsList[indexPath.row]
        
        return cell
    }
}
    
extension SuggestionTableDatasource:UITableViewDelegate
{
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let suggestion = suggestionsList[indexPath.row]
        
        if let delegate = self.delegate
        {
            delegate.suggestionTapped(suggestion)
        }
    }
}
