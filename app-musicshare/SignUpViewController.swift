//
//  SignUpViewController.swift
//  Projet
//
//  Created by Joseph Abi Rached on 11/01/2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func signup(_ sender: Any) {
        if email.text != "" && isValidEmail(email.text ?? ""){
            if password.text != ""{
                if password.text!.count > 6 {
                    if password.text == confirmPassword.text{
                        //sign up the user here
                        let auth = Auth.auth()
                        
                        auth.createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
                            if error != nil {
                                self.displayError(error?.localizedDescription ?? "An error has occured")
                                return
                            }
                            else{
                                self.displayError("")
                                return
                            }
                            
                        }
                        
                    }else{
                        displayError("Passwords must match!")
                    }
                } else{
                    displayError("Password must be at least 6 characters long!")
                }
            }else{
                displayError("Please enter a password!")
            }
        }else{
            displayError("Please enter a valid email!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //Checks if the email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //Checks if the string contains white spaces
    func hasWhiteSpace(_ str: String) -> Bool{
        let whiteSpace = " "
        if str.range(of:whiteSpace) != nil {
                    return true
              } else {
                    return false
        }
    }
    
    //Displays the error message
    func displayError(_ message: String, _ color: UIColor = UIColor.red){
        if message != "" {
            errorLabel.textColor = color
            errorLabel.text = message
        }
        else{
            errorLabel.textColor = UIColor.green
            errorLabel.text = "No error!"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
