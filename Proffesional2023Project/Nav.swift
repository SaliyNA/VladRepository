//
//  Nav.swift
//  ChampNation
//
//  Created by admin on 27.06.2023.
//

import Foundation

struct User{
    var uid: String = ""
    var email: String? = nil
    var phone: String = ""
    var fullName: String = ""
}


class Nav : ObservableObject{
    @Published var currentView : String = "onBoarding"
    @Published var user = User()
    
    init(){
        
        if UserDefaults.standard.bool(forKey: "isOnbShowed"){
            currentView = "signIn"
        }
        else{
            currentView = "onBoarding"
        }
    }
}
