//
//  HashGenerator.swift
//  Marvel
//
//  Created by mac on 7/3/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import CryptoSwift

class HashGenerator {
    
    class func MD5() -> (String, String)
    {
        let publicKey = Constants.API_KEY
        let privateKey = Constants.PRIVATE_KEY
        let uuid = NSUUID().uuidString
        let total = uuid+privateKey+publicKey
        let hash = total.md5()
        
        return (uuid, hash)
    }
}
