//
//  RemoteStore.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

class RemoteStore: StoreProtocol
{
    static func getAllMovies(success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        NetworkLayer.getAllMovies(success:success, failure:failure)
    }
    
    static func searchMovies(_ moviesName:String, page:Int, success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        NetworkLayer.searchMovies(moviesName, page:page, success:success, failure:failure)
    }
    
    static func downloadImage(url:String, success:@escaping(_ image:UIImage) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        NetworkLayer.downloadImage(url:url, success:success, failure:failure)
    }
}
