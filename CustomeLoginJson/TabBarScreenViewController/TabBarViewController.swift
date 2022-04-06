//
//  TabBarViewController.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 01/04/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let PeliculaTableVC = PeliculaTableViewController()
        let PeliculaFavoriteVC = PeliculasFavoritasViewController()
        let DetailsUserVC = DetailsUserViewController()
        
        PeliculaTableVC.title = "Peliculas"
        PeliculaFavoriteVC.title = "Favoritos"
        DetailsUserVC.title = "Usuario"
        
        self.setViewControllers([PeliculaTableVC, PeliculaFavoriteVC, DetailsUserVC], animated: true)
        
        guard let imagenTabBar = self.tabBar.items else {return}
        let imagenes = ["house","star","person"]
        
        for x in 0...2 {
            imagenTabBar[x].image = UIImage(systemName: imagenes[x])
        }
    }
}
