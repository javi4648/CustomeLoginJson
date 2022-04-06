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

        //datos del documento
        let docRef = db.collection("users").document(datosUsuario!.uid)
        let consulta : Void = docRef.getDocument{ (document, err) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing: )) ?? "nil"
                print("document data\(dataDescription)")
            
            } else {
                print("el documento no existe")
            }
            
        }
        
        //datos del usuario
        //lblNombreUser.text =
        lblEmailUser.text = datosUsuario!.email
    }
    
    
    
    


}
