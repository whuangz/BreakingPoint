//
//  Message.swift
//  BreakingPoint
//
//  Created by William Huang on 16/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import Foundation

class Message {
    private var _content: String
    private var _sender_id: String
    
    init(content: String, sender_id: String) {
        self._content = content
        self._sender_id = sender_id
    }
    
    var content: String {
        return _content
    }
    
    var sender_id: String{
        return _sender_id
    }
}
