//
//  ErrorModel.swift
//  Marvel
//
//  Created by mac on 7/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import ObjectMapper

struct ErrorModel : Error{
    let desc:String
    let code:Int
}

