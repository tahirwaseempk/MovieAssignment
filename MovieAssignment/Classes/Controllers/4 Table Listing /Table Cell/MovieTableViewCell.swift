//
//  MovieTableViewCell.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie:Movie!
    var delegate:TableCellProtocol?

    func loadData(_ movie:Movie, delegate:TableCellProtocol?)
    {
        self.movie = movie
        
        self.delegate = delegate
        
        contentTitleLabel.text = movie.movieTitle

        contentDateLabel.text = movie.movieReleaseDate

        favoriteButton.isSelected = movie.isMovieFavorite
        
        contentImageView.downloadImage(imageName:self.movie.movieLogoUrl ?? "", makeRound:false, defaultImageName:"NoPreviewImage")
    }
    
    @IBAction func favoriteButton_Tapped(_ sender: UIButton)
    {
        self.movie.isMovieFavorite = !self.movie.isMovieFavorite
        
        sender.isSelected = self.movie.isMovieFavorite
        
        LocalStore.saveMovie(movies:self.movie, success:
        {
            if let delegate = self.delegate
            {
                delegate.movieFavoriteTpped(movie:self.movie, success:
                {
                    
                }, failure: {(error:Error?) in
                    
                })
            }
        }) { (error:Error?) in
            
            // show error received while saving
        }
    }
    
    @IBAction func nextArrowButton_Tapped(_ sender: Any)
    {
        
    }
}
