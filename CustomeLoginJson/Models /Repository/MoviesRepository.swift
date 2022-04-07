//
//  MoviesRepository.swift
//  CustomeLoginJson
//
//  Created by Adrian Dominguez Gómez on 06/04/22.
//

import Foundation

protocol RepositoryDelegate {
    
    func didUpdateData()
    func didSearchMovie(movie:Movie)

}

class MoviesRepository {
    var delegate: RepositoryDelegate?
    var arrPopulates : [Movie]?
    var arrUpcoming : [Movie]?
   
    init(){}
    
    func getData(){
        let servicesManager = ExecuteServiceMovies()
        servicesManager.excecuteAPI(url: Urls.populates) { [weak self] movies in
            self?.arrPopulates = movies
            self?.delegate?.didUpdateData()
        }
        let serviceForUpcomming = ExecuteServiceMovies()
        serviceForUpcomming.excecuteAPI(url: Urls.upcomming) {[weak self] movies in
            self?.arrUpcoming = movies
            self?.delegate?.didUpdateData()
        }
        
    }
    
    
    func getUpcomming()-> [Movie]
    {
        return arrUpcoming ?? []
    }
    
    
    func getPopulates()->[Movie]{
        return arrPopulates ?? []
    }
   
    
    func searchMovie(id:String){
        
        //validamos en nuestro cache osea en los atributos de la clase
        var movie = arrUpcoming?.filter({ movie in
            return movie.id == Int(id)
        }).first
        
         
        
        if let movieSearched = movie {
            delegate?.didSearchMovie(movie: movieSearched)
            return
        }
        
        movie = arrPopulates?.filter({ movie in
           return movie.id == Int(id)
       }).first
       
        if let movieSearched = movie {
            delegate?.didSearchMovie(movie: movieSearched)
            return
        }
        
        
        
        
        //Aqui les toca hacer el nuevvo servicio y al devolver el resultado hay que invocar al delegate
        
        let apiService = SearchMovieService()
        
        apiService.excecute(idmovie: id, url: Urls.searchMovies) { [weak self] movie in
            self?.delegate?.didSearchMovie(movie: movie)
        }
        
    }
    
    
    
}
