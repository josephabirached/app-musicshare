//
//  ViewController.swift
//  Projet
//
//  Created by Joseph Abi Rached on 11/01/2021.
//

import UIKit

class ViewController: UIViewController {

    //Sign In
    @IBOutlet weak var signinEmail: UITextField!
    @IBOutlet weak var signinPassword: UITextField!
    @IBOutlet weak var signinError: UILabel!
    @IBOutlet weak var signin: UIButton!
    
    @IBAction func signin(_ sender: UIButton) {
        var errorMessage: String = ""
        
        if(signinEmail.text != ""){
            if(signinPassword.text != ""){
                if(isValidEmail(signinEmail.text ?? "")){
                    if(checkUser(signinEmail.text ?? "", password: signinPassword.text ?? "")){
                        errorMsg = "Welcome"
                    }else{
                        errorMessage = "Invalid email or password"
                    }
                }
                else{
                    errorMessage = "Please enter a valid email!"
                }
            }
            else{
                errorMessage = "Please enter a password!"
            }
        }else{
            errorMessage = "Please enter an email!"
        }
        
        if(errorMessage != ""){
            signinError.textColor = UIColor.red
            signinError.text = errorMessage
        }else{
            signinError.textColor = UIColor.green
            signinError.text = "No error"
        }
    }
    
    //Coradata
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Data for the table
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //tableView.dataSource = self
        //tableView.delegate = self
        
        fetchUsers()
        
       /* if let path = Bundle.main.path(forResource: "Users", ofType: "json"){
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
    
    func fetchUsers(){
        //fetch the data from core data
        //context.fetch
    }
    
    var errorMsg : String?

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkUser(_ email: String, password: String) -> Bool{
        if email == "" || password == "" {
            return false
        }
        
        /*for x in data{
            if x.email == email {
                if x.password == password{
                    return true
                }
                return false
            }
        }*/
        return false
    }
    
}


