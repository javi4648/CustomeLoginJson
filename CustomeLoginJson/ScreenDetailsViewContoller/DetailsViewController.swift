//
//  DetailsViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 31/03/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DetailsViewController: UIViewController {

    @IBOutlet weak var imgPelicula: UIImageView!
    @IBOutlet weak var lblNombrePelicula: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblLenguaje: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var btnAddFavorites: UIButton!
    @IBOutlet weak var btnDeleteFavotires: UIButton!
    
    let db = Firestore.firestore()
    let datosUsuario = Auth.auth().currentUser
    var struc : Movie?
    var dowlandImage : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if
            let nombrePelicula = struc?.original_title,
            let descripcion = struc?.overview,
            let lenguaje = struc?.original_language,
            let fecha = struc?.release_date,
            let imagen = struc?.poster_path {
            
            lblNombrePelicula.text = nombrePelicula
            lblDescripcion.text = descripcion
            lblLenguaje.text = "lenguaje: " + lenguaje
            lblFecha.text = "Fecha de lanzamiento: " + fecha
            
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            let posterPath = imagen
            let linkComplete = linkDefault + posterPath
            imgPelicula.downloaded(from: linkComplete)
            
        }
  
    }
    
    @IBAction func btnAddFavorites(_ sender: Any) {
        //acceder a los datos del usuario (solo el uid y el email)
        
        
        //id de la pelicula
        guard let id = struc?.id else {return}
        
        //nombre de la pelicula
        //guard let nombre = struc?.original_title else {return}
        
        db.collection("MovieFavorites").document(datosUsuario!.uid).(["": id] , merge: true){ err in
            if let err = err {
                print("Archivo: \(err) añadido a pelicula")
            }else {
                print("Archivo añadido a peliculas")
            }
        }
        
    }
    
    @IBAction func btnDeleteFavorites(_ sender: Any) {
        guard let idPelicula = struc?.id else {return}
        
        db.collection("MovieFavorites").document(datosUsuario!.uid).delete() { err in
            if let err = err {
                print("error removiento el documento: \(err)")
                
            }else {
                print("el documento ha sido eliminado")
                
            }
        }
    }
    


}
