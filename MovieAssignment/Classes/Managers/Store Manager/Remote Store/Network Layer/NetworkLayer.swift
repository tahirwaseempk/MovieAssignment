//
//  NetworkLayer.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

public class NetworkLayer
{
    static let userCacheQueue = OperationQueue()

    static func getAllMovies(success:@escaping(_ data:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        NetworkLayer.postData(url:GET_MOVIES_API_PATH, success:success, failure:failure)
    }
    
    static func searchMovies(_ moviesName:String, page:Int, success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        let url = SEARCH_API_PATH+moviesName+"&page=\(page)"
        
        NetworkLayer.postData(url:url, success:success, failure:failure)
    }

    static func postData(url:String, success:@escaping(_ data:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        guard let url = URL(string:url) else
        {
            failure(nil)
            
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler:{(data, response, error) in
        
            if let error = error
            {
                DispatchQueue.main.async
                {
                    CacheManager.checkCachedData(url:url, error:error, success:success, failure:failure)
                }

                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else
            {
                DispatchQueue.main.async
                {
                    CacheManager.checkCachedData(url:url, error:nil, success:success, failure:failure)
                }
                
                return
            }

            if let data = data
            {
                data.prettyPrintedJSONString()

                do
                {
                    if let json = try JSONSerialization.jsonObject(with:data, options:[]) as? Dictionary<String,Any>
                    {
                        CacheManager.pushToCache(url:url, json:json)
                        
                        DispatchQueue.main.async
                        {
                            success(json)
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async
                        {
                            CacheManager.checkCachedData(url:url, error:nil, success:success, failure:failure)
                        }
                    }
                }
                catch
                {
                    DispatchQueue.main.async
                    {
                        CacheManager.checkCachedData(url:url, error:error, success:success, failure:failure)
                    }
                }
            }
        })
    
      task.resume()
    }
    
    static func downloadImage(url:String, success:@escaping(_ image:UIImage) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        guard let url = URL(string:url) else
        {
            failure(nil)
            
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
             
             if let response = data, let image = UIImage(data:response)
             {
                success(image)
             }
             else
             {
                failure(nil)
             }
        }.resume()
    }
    
}
