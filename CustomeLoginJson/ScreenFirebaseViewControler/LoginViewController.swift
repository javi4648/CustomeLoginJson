//
//  LoginViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 30/03/22.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpElements()
    }
        
    //Aciones del boton
    @IBAction func btnActionLogin(_ sender: Any) {
        
        let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (Result, error) in
            
            if error != nil {
                self.lblError.text = error!.localizedDescription
                self.lblError.alpha = 1
            
            } else {
                let tabBar = TabBarViewController()
              
                DispatchQueue.main.async {
                    UserProfile.shared.profileID = Result?.user.uid
                    if let nav = self.navigationController {
                        nav.pushViewController(tabBar, animated: true)
                    }
                }
            }
        }
    }
    
    func SetUpElements () {
        lblError.alpha = 0
    }
    
}
