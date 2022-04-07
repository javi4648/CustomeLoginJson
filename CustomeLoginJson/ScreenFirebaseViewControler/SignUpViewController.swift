//
//  SignUpViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 30/03/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSAlphaCero()

    }

    @IBAction func btnActionSignIn(_ sender: Any) {
        //validar datos
        let error = validateField()
        if error != nil {
            errorLbl(error!)
        
        } else {

            FirebaseAuthentication()
            
        }
        
    }
    
    //metodos de firebase
    func FirebaseAuthentication () {
            let name = txtName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = txtLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //enviar los datos a firebase
        Auth.auth().createUser(withEmail: email, password: password){ (Result, err) in
            if err != nil {
               // print(err?.localizedDescription)
                self.errorLbl("Error creando el usuario")
                
            } else {
                let db = Firestore.firestore()
                
                db.collection("users").document(Result!.user.uid).setData(["name": name, "lastName": lastName, "uid": Result!.user.uid]) { (error) in
                    
                    if error != nil {
                        self.errorLbl("Error al guardar los datos del usuario")
                    }
                        
                }
                
                //ir a tableview
                self.transitionToTableView()
                
            }
            
        }
    }
    
    
    //validar los datos
    func validateField () -> String? {
        if
            txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Por favor, rellenene todos los campos"
            
        }
        
        let cleanenPassword = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanenPassword) == true {
            return "Asegurate que el Passoword cumpla con todos los paramentros"
        }
        
        return nil
    }
    
    //validar passoword 
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    

    //funcion para acceder a la pantalla de la tableView
    func transitionToTableView() {
        let tabBar = TabBarViewController()
      
        DispatchQueue.main.async {
            if let nav = self.navigationController {
                nav.pushViewController(tabBar, animated: true)
            }
        }
    }
    
    //ocultar el lbl de error
    func lblSAlphaCero () {
        lblError.alpha = 0
    }
    
    //activar el txtError, con el mensaje que se mando
    func errorLbl(_ message : String) {
        lblError.text = message
        lblError.alpha = 1
    }
    
    
}
