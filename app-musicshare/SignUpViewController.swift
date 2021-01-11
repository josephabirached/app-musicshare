//
//  SignUpViewController.swift
//  Projet
//
//  Created by Joseph Abi Rached on 11/01/2021.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func signup(_ sender: Any) {
        var errorMessage: String = ""
        var errorCode: Int = 0
        if username.text != ""{
            if email.text != "" && isValidEmail(email.text ?? ""){
                if password.text != ""{
                    if password.text == confirmPassword.text{
                        errorCode = signUpUser(username: username.text, email: email.text, password: password.text)
                    }else{
                        errorMessage = "Passwords must match!"
                    }
                }else{
                    errorMessage = "Please enter a password!"
                }
            }else{
                errorMessage = "Please enter a valid email!"
            }
        }else{
            errorMessage = "Please enter a username!"
        }
        
        if(errorMessage != ""){
            errorLabel.textColor = UIColor.red
            errorLabel.text = errorMessage
        }
        else if errorCode != 0{
            errorLabel.textColor = UIColor.red
            switch errorCode{
            case 1:
                errorLabel.text = "Bad request!"
            case 2:
                errorLabel.text = "Username must not contain spaces!"
            case  3:
                errorLabel.text = "Username already exist!"
            case 4:
                errorLabel.text = "Email already in use!"
            default:
                errorLabel.text = ""
            }
        }else{
            errorLabel.textColor = UIColor.green
            errorLabel.text = "No error"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if let path = Bundle.main.path(forResource: "Users", ofType: "json"){
            if let str = try? String(contentsOfFile: path){
                
                let rawData = Data(str.utf8)
                
                if let jsonData = try? JSONDecoder().decode(Users.self, from: rawData){
                    data = jsonData.results
                }else{
                    errorMsg = "ERROR: no json data"
                }
            } else {
                errorMsg = "ERROR: no txt data"
            }
        }else {
            errorMsg = "ERROR: file does not exist !"
        }
        
        if let error = errorMsg{
            print(error)
        }*/
    }
    
    //var data: [User] = []
    var errorMsg : String?

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func hasWhiteSpace(_ str: String) -> Bool{
        let whiteSpace = " "
        if str.range(of:whiteSpace) != nil {
                    return true
              } else {
                    return false
        }
    }
    
    func signUpUser(username: String?, email: String?, password: String?) -> Int{
        //Check if emtpy
        if  password == "" || email == "" || password == "" || password == nil || email == nil || password == nil {
            return 1
        }
        if hasWhiteSpace(username!){
            return 2
        }
        
        //Check if the email or username are already taken
        /*for x in data{
            if x.username == username{
                return 3
            }
            if x.email == email{
                return 4
            }
        }*/
        
        
        return 0
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
