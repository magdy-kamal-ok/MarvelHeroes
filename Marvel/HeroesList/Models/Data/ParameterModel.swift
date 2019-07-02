//
//  ParameterModel.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
struct ParameterModel : Encodable {
    
    var apikey:String = ""
    var hash:String = ""
    var ts:String = ""
    var offset:Int = 0
    
    init(offset:Int = 0) {
        self.offset = offset
        apikey =  Constants.API_KEY
        let hashGenerated = HashGenerator.MD5()
        self.ts = hashGenerated.0
        self.hash = hashGenerated.1
    }
    
    
}
