//
//  DataService.swift
//  BreakingPoint
//
//  Created by William Huang on 04/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    private let _BASE_REF = DB_BASE
    private let _USER_REF = DB_BASE.child("users")
    private let _GROUP_REF = DB_BASE.child("groups")
    private let _FEED_REF = DB_BASE.child("feeds")
    
    var BASE_REF: DatabaseReference {
        return _BASE_REF
    }
    
    var USER_REF: DatabaseReference {
        return _USER_REF
    }
    
    var GROUP_REF: DatabaseReference {
        return _GROUP_REF
    }
    
    var FEED_REF: DatabaseReference {
        return _FEED_REF
    }
    
    func createUserDB(uid: String, data: Dictionary<String,Any>){
        USER_REF.child(uid).updateChildValues(data)
    }
    
    func uploadPost(withMsg msg: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool)->()){
        if groupKey != nil {
            // send to group ref
            let body = [
                "content": msg,
                "sender_id": uid
            ]
            GROUP_REF.child(groupKey!).child("messages").childByAutoId().updateChildValues(body)
        }else{
            // send to feed
            FEED_REF.childByAutoId().updateChildValues(["content": msg, "sender_id": uid])
            sendComplete(true)
        }
    }
    
    
    
    func getUserName(forUid uid: String, handler: @escaping (_ userName: String)->()){
        USER_REF.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let usersSnapShot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in usersSnapShot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getAllMessagesForGroup(group: Group, handler: @escaping (_ messages: [Message])->()){
        var messages = [Message]()
        GROUP_REF.child(group.groupKey).child("messages").observeSingleEvent(of: .value) { (groupFeedSnapShot) in
            guard let groupFeedSnapShot = groupFeedSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for msg in groupFeedSnapShot {
                let content = msg.childSnapshot(forPath: "content").value as! String
                let sender_id = msg.childSnapshot(forPath: "sender_id").value as! String
                messages.append(Message(content: content, sender_id: sender_id))
            }
        }
        
        handler(messages)
    }
    
    func getAllMessages(handler: @escaping (_ messages: [Message])->()){
        var messageArray = [Message]()
        FEED_REF.observeSingleEvent(of: .value) { (feedSnapshot) in
            guard let feedSnapshot = feedSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for msg in feedSnapshot {
                let content = msg.childSnapshot(forPath: "content").value as! String
                let sender_id = msg.childSnapshot(forPath: "sender_id").value as! String
                messageArray.append(Message(content: content, sender_id: sender_id))
            }
            
            handler(messageArray)
        }
    }
    
    func getAllGroups(handler: @escaping (_ groups: [Group])->()){
        var groups = [Group]()
        GROUP_REF.observeSingleEvent(of: .value) { (groupSnapShot) in
            guard let groupSnapShot = groupSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for group in groupSnapShot {
                let members = group.childSnapshot(forPath: "members").value as! [String]
                if members.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let desc = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, desc: desc, key: group.key, members: members)
                    
                    groups.append(group)
                }
            }
            
            handler(groups)
        }
    }
    
    func getEmail(forSearchQuery query:String, handler: @escaping (_ emails: [String])->()){
        var emailArray = [String]()
        USER_REF.observe(.value) { (userSnapShot) in
            guard let userSnapshot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true {
                    if email != Auth.auth().currentUser?.email{
                        emailArray.append(email)
                    }
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forEmailNames emailNames: [String], handler: @escaping (_ ids: [String])->()){
        var ids = [String]()
        USER_REF.observeSingleEvent(of: .value) { (userDataSnapshot) in
            guard let userSnapShot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapShot{
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if emailNames.contains(email){
                    ids.append(user.key)
                }
            }
        }
        handler(ids)
    }
    
    func getEmailForGroup(group: Group, handler: @escaping (_ emails: [String])->()) {
        var emails = [String]()
        USER_REF.observe(.value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapShot{
                if group.members.contains(user.key){
                    let email = user.childSnapshot(forPath: "email").value as! String

                    emails.append(email)
                }
            }
            handler(emails)
        }
    }
    
    func createGroup(forTitle title:String, forDesc desc: String, forUserIds ids: [String], sendComplete: @escaping (_ status: Bool)->()){
        let body = [
            "title": title,
            "description": desc,
            "members": ids
            ] as [String : Any]
        GROUP_REF.childByAutoId().updateChildValues(body)
        sendComplete(true)
    }
}
