//
//  User.swift
//  ACTDigital
//
//  Created by Thiago Soares on 11/05/23.
//

import Foundation

struct User: Decodable {
    var login: String?
    var id: Int?
    let name: String?
    var avatar_url: String?
    let company: String?
    let twitter_username: String?
    let location: String?
    let blog: String?
    let followers: Int?
    let following: Int?
}
