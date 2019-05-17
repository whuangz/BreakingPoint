//
//  Group.swift
//  BreakingPoint
//
//  Created by William Huang on 24/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import Foundation

class Group {
    private var _groupTitle: String
    private var _groupDesc: String
    private var _groupKey: String
    //private var _membersCount: Int
    private var _members: [String]
    
    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDesc: String {
        return _groupDesc
    }
    
    var groupKey: String {
        return _groupKey
    }
    
    var members: [String] {
        return _members
    }
    
    init(title: String, desc: String, key: String, members: [String]) {
        self._groupTitle = title
        self._groupDesc = desc
        self._groupKey = key
        self._members = members
    }
}
