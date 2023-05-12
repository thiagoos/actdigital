//
//  BaseViewController.swift
//  ACTDigital
//
//  Created by Thiago Soares on 11/05/23.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK: - UI
    let loadingView = LoadingView()
    let errorView = CustomErrorView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
