//
//  ParserProtocol.swift
//  CheetahAssignment
//
//  Created by Waseem on 22/06/2020.
//  Copyright © 2020 Waseem. All rights reserved.
//

import Foundation

protocol Parser
{
    func parse(_ json:Dictionary<String,Any>) -> Any?
}
