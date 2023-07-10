//
//  SignUpVM.swift
//  ChampNation
//
//  Created by admin on 27.06.2023.
//

import Foundation
import Supabase
class SingUpVM : ObservableObject{
    @Published var nav : Nav
    
    init(nav: Nav){
        self.nav = nav
    }
    
    func isFormValid(email: String, password: String) -> Bool{
        guard email.isValidEmail(), password.count > 7 else{
            return false
        }
        return true
    }
    func registerNewUserWithEmail(email:String, password: String) async throws -> AppUser{
        if isFormValid(email: email, password: password){
            return try await AuthManager.shared.registerNewUserWithEmail(email: email, password: password)
        }else{
            print("form is invalid")
            throw NSError()
        }
    }
   
}
