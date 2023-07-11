//
//  SignInVM.swift
//  Proffesional2023Project
//
//  Created by admin on 28.06.2023.
//

//MARK:VM EMAIL////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import Foundation




class SignInVM: ObservableObject{
    @Published var nav : Nav
    @Published var isPress1: Bool = false
    @Published var isPress: Bool = false
    @Published var signInModel = SignInModel(email: "", password: "")
    init(nav: Nav){
        self.nav = nav
    }
    
    func isFormValid(email: String, password: String) -> Bool{
        if signInModel.email == "" || signInModel.password == "" {
            self.isPress = true
            return false
        }
        else {
            guard email.isValidEmail() else{
                self.isPress1 = true
                return false
                
            }
            return true
        }
    }
    func registerNewUserWithEmail(email:String, password: String) async throws -> AppUser{
        if isFormValid(email: email, password: password){
            return try await AuthManager.shared.registerNewUserWithEmail(email: email, password: password)
        }else{
            print("form is invalid")
            throw NSError()
        }
    }
    func SignInWithEmail(email:String, password: String) async throws -> AppUser{
        if isFormValid(email: email, password: password){
            let user  = try await AuthManager.shared.signInWithEmail(email: email, password: password)
            return user
        }else{
            print("sign in form is invalid")
            throw NSError()
        }
    }
}
extension String {
    func isValidEmail()->Bool{
        let emailFormat = "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
