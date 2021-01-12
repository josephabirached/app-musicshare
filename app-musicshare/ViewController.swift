//
//  ViewController.swift
//  Projet
//
//  Created by Joseph Abi Rached on 11/01/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    //Sign In
    @IBOutlet weak var signinEmail: UITextField!
    @IBOutlet weak var signinPassword: UITextField!
    @IBOutlet weak var signinError: UILabel!
    @IBOutlet weak var signin: UIButton!
    
    //Sign in button clicked
    @IBAction func signin(_ sender: UIButton) {
        
        if(signinEmail.text != ""){
            if(signinPassword.text != ""){
                if(isValidEmail(signinEmail.text!)){
                    
                    //Create an instance of Firebase auth and try to login
                    let auth = Auth.auth()
                        auth.signIn(withEmail: signinEmail.text!, password: signinPassword.text!) { (authResult, error) in
                            //Checks if the email exists and/or if the password is correct
                            if error != nil{ print(error!) ; self.displayError("Wrong email or password") }
                            else{ self.displayError("") }
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
    
    
    var errorMsg : String?

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
        else{
            signinError.textColor = UIColor.green
            signinError.text = "No error!"
        }
    }
    
}


