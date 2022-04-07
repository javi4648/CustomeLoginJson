//
//  PeliculasFavoritasViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 01/04/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PeliculasFavoritasViewController: UIViewController {

    @IBOutlet weak var PeliculasFavoritasTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        descargarDatos()
        
    }
    
    
    func descargarDatos (){
        let db = Firestore.firestore()
        let datosUsuario = Auth.auth().currentUser
        guard let idUusario = datosUsuario?.uid else { return }
        
        //datos del documento
        let datosMovieFav = db.collection("MovieFavorites").document(idUusario)
        
        //traer los datos del diccionario del usuario
        datosMovieFav.getDocument {(document, err) in
            if let document = document, document.exists {
                if let dataDictionary = document.data(){
                    for item in dataDictionary { print(item.value)}
                }
            }else {
                print("Document don't exist")
            }
        }
    }


}
