//
//  PeliculaTableViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 30/03/22.
//

import UIKit

class PeliculaTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //declarar la tabla
    @IBOutlet weak var PeliculasTableViewController: UITableView!
    
    //Añadir el arrego del Json
    var moviesPopulate: [Movie] = []
    var moviesUpComming: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nombre del la tabla
        title = "Peliculas"

        //agregar delegados
        PeliculasTableViewController.delegate = self
        PeliculasTableViewController.dataSource = self
        
        //Registar la celda
        let cell = UINib(nibName: "MoviePopulateTableViewCell", bundle: nil)
        PeliculasTableViewController.register(cell, forCellReuseIdentifier: "MoviePopulateTableViewCell")
                
        //inicializar el decoder
        let apiService = ExecuteServiceMovies()
        
        //para la funcion de la parte de populates
        let completionPopulates : ([Movie]) -> Void = { [weak self] movieItem in
            self?.moviesPopulate = movieItem
            self?.PeliculasTableViewController.reloadData()
        }
        
        //para pintar la celda populates
        apiService.excecuteAPI(url: Urls.populates, complited: completionPopulates)
        
        //para pintar la celda UpComing
        apiService.excecuteAPI(url: Urls.upcomming){  movies in
            self.moviesUpComming = movies
            self.PeliculasTableViewController.reloadData()
        }
        
    }
    
    //para dividir lo en secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //para darle un titulo a las secciones
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0 ) {
            return "Movies Populates"
        }else {
            return "Movies UpComming"
        }
    }
    
    //para escribir el numero de secciones
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return moviesPopulate.count
        }else {
            return moviesUpComming.count
        }
    }
    
    //para pintar todas las celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            
            //declarar la celda
            let cellPopularity = PeliculasTableViewController.dequeueReusableCell(withIdentifier:"MoviePopulateTableViewCell" , for: indexPath) as! MoviePopulateTableViewCell
            
            //llenar los datos de la celda
            cellPopularity.lblNombrePelicula?.text = moviesPopulate[indexPath.row].original_title?.capitalized
            cellPopularity.lblLenguaje?.text = moviesPopulate[indexPath.row].original_language?.capitalized
            cellPopularity.lblFecha?.text = moviesPopulate[indexPath.row].release_date?.capitalized
            
            //definir el delegado de la celda, para que se pueda utilzar el boton
            //cellPopularity.addMoviePopulateFavoriteDelegate = self
            
            //descargar la imagen
            cellPopularity.imageView?.contentMode = .scaleAspectFit
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            if let posterPath = moviesPopulate[indexPath.row].poster_path {
                let linkComplete = linkDefault + posterPath
                cellPopularity.imgPelicula.downloaded(from: linkComplete)
            }
            
            return cellPopularity

        }else {
            
            //declarar la celda
            let cellUpComming = PeliculasTableViewController.dequeueReusableCell(withIdentifier: "MoviePopulateTableViewCell", for: indexPath) as! MoviePopulateTableViewCell
            
            //llenar los campos de la celda
            cellUpComming.lblNombrePelicula?.text = moviesUpComming[indexPath.row].original_title?.capitalized
            cellUpComming.lblLenguaje?.text = moviesUpComming[indexPath.row].original_language?.capitalized
            cellUpComming.lblFecha?.text = moviesUpComming[indexPath.row].release_date?.capitalized
            
            //descargar la imagen
            cellUpComming.imageView?.contentMode = .scaleAspectFit
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            if let posterPath = moviesUpComming[indexPath.row].poster_path {
                let linkComplete = linkDefault + posterPath
                cellUpComming.imgPelicula.downloaded(from: linkComplete)
            }
            
            return cellUpComming
        }
    }

    //cuando se selecciones
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            let detalles = DetailsViewController()
            let array = moviesPopulate[indexPath.row]
            detalles.struc = array
            navigationController?.pushViewController(detalles, animated: true)
            
        }else {
            let detalles = DetailsViewController()
            let array = moviesUpComming[indexPath.row]
            detalles.struc = array
            navigationController?.pushViewController(detalles, animated: true)
            
        }

        
    }
    
}
