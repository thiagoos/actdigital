//
//  Repo.swift
//  ACTDigital
//
//  Created by Thiago Soares on 11/05/23.
//

import Foundation

struct Repo: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let visibility: String?
    let html_url: String?
    let language: String?
}
