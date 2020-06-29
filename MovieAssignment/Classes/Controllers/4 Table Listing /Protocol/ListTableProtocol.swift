//
//  ListTableProtocol.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit

protocol ListTableProtocol
{
    func loadPageData(page:Int, success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    func refreshData(success:@escaping(_ data:Array<Movie>) -> Void, failure:@escaping(_ error:Error?) -> Void)
    func movieFavoriteTpped(movie:Movie, success:@escaping() -> Void, failure:@escaping(_ error:Error?) -> Void)
}
