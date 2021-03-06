//
//  SignInViewController.swift
//  Projet
//
//  Created by Joseph Abi Rached on 11/01/2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    //Sign in
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signinError: UILabel!

    
    
    //Sign in button clicked
    @IBAction func signIn(_ sender: Any) {
        if(email.text != ""){
            if(password.text != ""){
                if(isValidEmail(email.text!)){
                    
                    //Create an instance of Firebase auth and try to login
                    let auth = Auth.auth()
                        auth.signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
                            //Checks if the email exists and/or if the password is correct
                            if error != nil{ print(error!) ; self.displayError("Wrong email or password") }
                            else{
                                self.displayError("")
                                UserDefaults.standard.set(self.email.text!, forKey: "emailKey")
                                let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
                                let viewController = storyboard.instantiateInitialViewController()
                                 
                                if let viewController = viewController {
                                    viewController.modalPresentationStyle = .fullScreen
                                    self.present(viewController, animated: true, completion: nil)
                                }
                            }
                        }
                }
                else{
                    displayError("Please enter a valid email!")
                }
            }
            else{
                displayError("Please enter a password!")
            }
        }else{
            displayError("Please enter an email!")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    

    //Checks if the email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //Displays the error message
    func displayError(_ message: String, _ color: UIColor = UIColor.red){
        if message != "" {
            signinError.textColor = color
            signinError.text = message
        }
    }
    
}
