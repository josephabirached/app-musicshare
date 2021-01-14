//
//  HomeViewController.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 14/01/2021.
//

import UIKit

class HomeViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email = UserDefaults.standard.string(forKey: "email")
        if email != nil {
            //email_label.text = "Welcome "+email!
        }
        
    }}
