//
//  DetailsUserViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 01/04/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class DetailsUserViewController: UIViewController {
    
    

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblEmailUser: UILabel!
    @IBOutlet weak var lblNombreUser: UILabel!
    @IBOutlet weak var lblApellidoUser: UILabel!
    @IBOutlet weak var btnCambiarDatos: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GuardarDatos()
        

    }
    
    func GuardarDatos () {
        let db = Firestore.firestore()
        let datosUsuario = Auth.auth().currentUser
        guard let idUsuario = datosUsuario?.uid else {return}

        //datos del documento
        let datoUser = db.collection("users").document(idUsuario)
        
        //traer los datos del diccionario de usuarios
        datoUser.getDocument {(document, err) in
            if let document = document, document.exists {
                if let dataDictionary = document.data(){
                    self.lblNombreUser.text = dataDictionary["name"] as? String
                    self.lblApellidoUser.text = dataDictionary["lastName"] as? String
                    for item in dataDictionary { print(item.value) }
                }
               
            }else {
                print("Document no exist")
            }
        }
        
        lblEmailUser.text = datosUsuario!.email
    }
    
}
