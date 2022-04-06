//
//  UserProfile.swift
//  CustomeLoginJson
//
//  Created by Gabriela Dominguez gomez on 05/04/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


class UserProfile {
    
    static let dataUser = Auth.auth().currentUser

    static let shared = UserProfile()
    
    var profileID :String?
    
    init () {}
    
    
    
}
