//
//  ProfileViewController.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 27/01/2021.
//

import UIKit

class ProfileViewController: UIViewController{
    
    

    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.text = UserDefaults.standard.string(forKey: "emailKey")
        
        
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "emailKey")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController()
         
        if let viewController = viewController {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}
