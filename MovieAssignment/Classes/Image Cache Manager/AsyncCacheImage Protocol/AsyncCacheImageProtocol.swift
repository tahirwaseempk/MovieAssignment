//
//  AsyncCacheImageProtocol.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

protocol AsyncCacheImageProtocol
{
    func makeRound()
    
    func downloadImage(imageName:String, makeRound:Bool, defaultImageName:String)
}
