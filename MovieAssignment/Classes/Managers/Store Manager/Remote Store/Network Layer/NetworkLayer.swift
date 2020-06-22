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
    static func getAllMovies(success:@escaping(_ data:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        NetworkLayer.postData(url:"https://api.themoviedb.org/3/movie/popular?api_key=e5ea3092880f4f3c25fbc537e9b37dc1", success:success, failure:failure)
    }
    
    static func searchMovies(_ moviesName:String, page:Int, success:@escaping(_ moviesJson:Dictionary<String,Any>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=e5ea3092880f4f3c25fbc537e9b37dc1&query="+moviesName+"&page=\(page)"
        
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
              failure(error)
            
              return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else
            {
                failure(nil)
              
                return
            }

            if let data = data
            {
                data.prettyPrintedJSONString()

                do
                {
                    if let json = try JSONSerialization.jsonObject(with:data, options:[]) as? Dictionary<String,Any>
                    {
                        success(json)
                    }
                    else
                    {
                        failure(nil)
                    }
                }
                catch
                {
                    failure(error)
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
