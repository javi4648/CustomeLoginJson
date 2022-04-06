//
//  ViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 30/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLogIn: UIButton!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnActionLogin(_ sender: Any) {
        
        if let nac = self.navigationController {
            let login = LoginViewController()
           
            nac.pushViewController(login, animated: true)
        }
        
    }
    
    @IBAction func btnActionSignUp(_ sender: Any) {

        if let nav = self.navigationController {
            let signUp = SignUpViewController()
            
            nav.pushViewController(signUp, animated: true)
        }
        
    }
}

