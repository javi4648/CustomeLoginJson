//
//  MoviePopulateTableViewCell.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 30/03/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class MoviePopulateTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPelicula: UIImageView!
    @IBOutlet weak var lblNombrePelicula: UILabel!
    @IBOutlet weak var lblLenguaje: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var btnAddFavorites: UIButton!
    
    
    var struc : Movie?
    var addMoviePopulateFavoriteDelegate : addMovieFavoriteProto?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddFavoriteCell(_ sender: Any) {
        addMoviePopulateFavoriteDelegate?.addFavirites(cell: self)
        
    }
        
}

protocol addMovieFavoriteProto {
    func addFavirites (cell: MoviePopulateTableViewCell)
}
