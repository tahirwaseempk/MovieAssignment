//
//  MovieDetailViewController.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var contentDescriptionTextView: UITextView!

    var movie:Movie!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI()
    {
        contentTitleLabel.text = self.movie.movieTitle
        
        bannerImageView.downloadImage(imageName:self.movie.movieBannerUrl ?? "", makeRound:false, defaultImageName:"NoPreviewImage")
         
        logoImageView.downloadImage(imageName:self.movie.movieLogoUrl ?? "", makeRound:false, defaultImageName:"NoPreviewImage")
         
        contentTitleLabel.text = self.movie.movieTitle
         
        contentDateLabel.text = self.movie.movieReleaseDate
        
        contentDescriptionTextView.text = self.movie.movieContents
        
        favoriteButton.isSelected = self.movie.isMovieFavorite
    }
    
    @IBAction func favoriteButton_Tapped(_ sender:UIButton)
    {
        self.movie.isMovieFavorite = !self.movie.isMovieFavorite
        
        sender.isSelected = self.movie.isMovieFavorite
        
        LocalStore.saveMovie(movies:self.movie, success:
        {
            // Show alert for successfully saving
            
        }) { (error:Error?) in
            
            // show error received while saving
        }
    }
    
    @IBAction func backButton_Tapped(_ sender: Any)
    {
        self.navigationController?.popViewController(animated:true)
    }
}
