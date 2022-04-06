//
//  Structures.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 30/03/22.
//

import Foundation

struct PopularesMovies: Decodable {
    var results : [Movie]
}

struct Movie: Decodable {
    var id : Int?
    var original_title : String?
    var original_language : String?
    var overview : String?
    var release_date : String?
    var poster_path: String?
    
}


// segunda estructura
struct UpCommingMovies: Decodable {
    var resultsMovieUC : [MovieUC]
}

struct MovieUC: Decodable {
    var original_title : String?
    var release_date : String?
    var overview : String?
    var original_language : String?
    var poster_path: String?
}
