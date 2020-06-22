//
//  SpinnyIndicator.swift
//  MovieAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import Foundation
import UIKit

class SpinnyIndicator: NSObject
{
    static private let presentingIndicatorTypes =
    {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    static func showSpinny()
    {
        self.showSpinny("")
    }
    
    static func showSpinny(_ textMessage:String)
    {
        let size = CGSize(width: 100, height: 45)
        
        let selectedIndicatorIndex = 29
        
        let indicatorType = presentingIndicatorTypes[selectedIndicatorIndex]
        
        NVActivityIndicatorViewable.startAnimating(size, message: textMessage, type: indicatorType, color:APP_THEME_ACTIVE_COLOR, fadeInAnimation: nil)
    }
    
    static func updateMessage(_ textMessage:String)
    {
        NVActivityIndicatorPresenter.sharedInstance.setMessage(textMessage)
    }
    
    static func hideSpinny()
    {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now())
        {
            NVActivityIndicatorViewable.stopAnimating(nil)
        }
    }
}
