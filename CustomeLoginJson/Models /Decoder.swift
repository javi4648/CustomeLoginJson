//
//  Decoder.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 30/03/22.
//

import Foundation

class Urls{
    static let upcomming = "https://api.themoviedb.org/3/movie/upcoming?api_key=c89f997b9f805d783c81fc1e854ed7d1"
    static let populates = "https://api.themoviedb.org/3/movie/popular?api_key=c89f997b9f805d783c81fc1e854ed7d1"
    static let searchMovies = "https://api.themoviedb.org/3/movie/{id}"
    
}
class ExecuteServiceMovies {
    
    func excecuteAPI(url:String, complited: @escaping (_ movies:[Movie]) -> () ) {
        // en donde se guardara la URL
        let urlSession = URLSession.shared
        // direccion de la URL
        let url = URL(string: url)
        
        
        urlSession.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let responseModel = try JSONDecoder().decode(PopularesMovies.self, from: data!)
                    print(responseModel)
                    DispatchQueue.main.async {
                        complited(responseModel.results)
                    }
                    
                }catch {
                    print("error JSON")
                }
            }
        }.resume()
    }
}

class SearchMovieService {
    
    func excecute(idmovie:String, url:String, complited: @escaping (_ movies:Movie) -> () ) {
    
        let finalString = url.replacingOccurrences(of: "{id}", with: idmovie)
        // en donde se guardara la URL
    
        
        let urlSession = URLSession.shared
        // direccion de la URL
        let url = URL(string: finalString)
        
        
        urlSession.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let responseModel = try JSONDecoder().decode(Movie.self, from: data!)
                    print(responseModel)
                    DispatchQueue.main.async {
                       complited(responseModel)
                    }
                    
                }catch {
                    print("error JSON")
                }
            }
        }.resume()
    }
}


