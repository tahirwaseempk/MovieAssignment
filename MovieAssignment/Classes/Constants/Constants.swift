//
//  AsyncCacheImageProtocol.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import UIKit
import Foundation

let APP_NAME = "Assignment"

let APP_THEME_ACTIVE_COLOR = UIColor.init(red: 32.0/255.0, green: 193.0/255.0, blue: 121.0/255.0, alpha: 1.0)

let APP_THEME_DE_ACTIVE_COLOR:UIColor = UIColor.lightGray

let ThemeChangedNotification = NSNotification.Name(rawValue: "Theme_Changed")

let PER_PAGE_ITEMS = 10

class Constants: NSObject
{
    public static func randomNumer() -> String
    {
        return String(Int.random(in: 0 ... 10000000))
    }
    
    public static func currentMillis() -> Int
    {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
    public static func millisToDate(millis:Int) -> Date
    {
        let timeInterval:TimeInterval = Double(millis / 1000)
        
        return Date(timeIntervalSince1970:timeInterval)
    }
    
    public static func stringFromDate_Time(date:Date) -> String
    {
        let dateFormatterGet = DateFormatter()
        
        dateFormatterGet.dateFormat = "MMM d, yyyy"
        
        return dateFormatterGet.string(from: date)
    }
    
    /*
         Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
         09/12/2018                        --> MM/dd/yyyy
         09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
         Sep 12, 2:11 PM                   --> MMM d, h:mm a
         September 2018                    --> MMMM yyyy
         Sep 12, 2018                      --> MMM d, yyyy
         Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
         2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
         12.09.18                          --> dd.MM.yy
         10:41:02.112                      --> HH:mm:ss.SSS
 */
}
