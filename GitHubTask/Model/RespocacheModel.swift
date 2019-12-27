//
//  RespocacheModel.swift
//  GitHubTask
//
//  Created by Shehata on 12/26/19.
//  Copyright © 2019 shehata. All rights reserved.
//

import Foundation
class RespocacheModel: NSObject, NSCoding {
    open var userName = ""
    open var ReposName = ""
    open var descrip = ""
    open var avater = ""
    open var fork = false
    open var reposURL = ""
    open var ownerURL  = ""
    
    override init() {
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.userName = aDecoder.decodeObject(forKey: "userName") as! String
        self.ReposName = aDecoder.decodeObject(forKey: "ReposName") as! String
        self.descrip = aDecoder.decodeObject(forKey: "descrip") as! String
        self.avater = aDecoder.decodeObject(forKey: "avater") as! String
        self.fork = Bool (aDecoder.decodeBool(forKey: "fork"))
        self.reposURL = aDecoder.decodeObject(forKey: "reposURL") as! String
        self.ownerURL = aDecoder.decodeObject(forKey: "ownerURL") as! String
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.ReposName, forKey: "ReposName")
        aCoder.encode(self.descrip, forKey: "descrip")
        aCoder.encode(self.avater, forKey: "avater")
        aCoder.encode(self.fork, forKey: "fork")
        aCoder.encode(self.reposURL, forKey: "reposURL")
        aCoder.encode(self.ownerURL, forKey: "ownerURL")
    }
}
