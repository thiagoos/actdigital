//
//  UserDetailViewModel.swift
//  ACTDigital
//
//  Created by Thiago Soares on 11/05/23.
//

import Foundation

protocol UserDetailViewModelProtocol {
    var user: User? { set get }
    var repo: [Repo]? { get set }
    var showLoading: (() -> Void)? { get set }
    var hideLoading: (() -> Void)? { get set }
}

class UserDetailViewModel: UserDetailViewModelProtocol {
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    
    var repo: [Repo]?
    
    var user: User?
    private let service = Service.sharedInstance
    
    init(user: User, repo: [Repo]) {
        self.user = user
        self.repo = repo
        self.hideLoading?()
    }
}
