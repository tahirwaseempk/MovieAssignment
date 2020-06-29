//
//  CacherTestCase.swift
//  MovieAssignmentTests
//
//  Created by Waseem on 29/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import XCTest
@testable import MovieAssignment

class CacheTestCase: XCTestCase
{
    func testReadWriteCache()
    {
        let jsonKey = "iAmKey"
        let jsonData = "iAmData"
        let json = [jsonKey:jsonData]
        let key = "testReadWriteCacheKey"
        
        DataCache.instance.write(object:json as NSCoding, forKey: key)
        
        let cachedJson = DataCache.instance.readDictionary(forKey: key)
        
        XCTAssert(cachedJson?[jsonKey] as! String == jsonData)
    }
}
