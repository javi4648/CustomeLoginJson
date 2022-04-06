//
//  DetailsUserTableViewCell.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 04/04/22.
//

import UIKit

class DetailsUserTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPeliculaFav: UIImageView!
    @IBOutlet weak var lblNombreMovie: UILabel!
    @IBOutlet weak var lblLenguaje: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblFecha: UILabel!
    
    var addMovieFavoriteDelegate : addFavoriteProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    

    @IBAction func btnAdd(_ sender: Any) {
        addMovieFavoriteDelegate?.addFavorite(cell: self)
    }
    
}

protocol addFavoriteProtocol {
    func addFavorite (cell: DetailsUserTableViewCell)
}
