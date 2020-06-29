//
//  File.swift
//  MovieAssignment
//
//  Created by Waseem on 29/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import Foundation

class CacheManager
{
    var userCacheURL: URL?

    static func checkCachedData(url:URL, error:Error?, success:@escaping(_ json:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        if let cacheData = DataCache.instance.readDictionary(forKey: url.absoluteString)
        {
            success(cacheData as! Dictionary<String,Any>)
        }
        else
        {
            failure(nil)
        }
    }
    
    static func pushToCache(url:URL, json:Dictionary<String,Any>)
    {
        DataCache.instance.write(dictionary:json, forKey:url.absoluteString)
    }
}
