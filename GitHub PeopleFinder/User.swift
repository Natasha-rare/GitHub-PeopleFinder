//
//  User.swift
//  GitHub PeopleFinder
//
//  Created by Наталья Автухович on 28.06.2021.
//

import Foundation

class User{
    let name: String
    let avatar: String
    let followers: Int
    let following: Int
    let bio: String
    
    init(name:String, avatar: String, followers:Int, following: Int, bio:String) {
        self.name = name
        self.avatar = avatar
        self.followers = followers
        self.following = following
        self.bio = bio
    }
    
    init(){
        self.name = ""
        self.avatar = ""
        self.followers = 0
        self.following = 0
        self.bio = ""
    }
}
