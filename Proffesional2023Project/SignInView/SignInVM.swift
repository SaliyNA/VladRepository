//
//  SignInVM.swift
//  Proffesional2023Project
//
//  Created by admin on 28.06.2023.
//

//MARK:VM EMAIL////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import Foundation
import CryptoKit

private func randomNonceString(lenght: Int = 32) -> String{
    precondition(lenght>0)
    var randomBytes = [UInt8](repeating: 0, count: lenght)
    let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    if errorCode != errSecSuccess {
        fatalError(
            "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
    }
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._")
    let nonce = randomBytes.map { byte in
        charset[Int(byte) % charset.count]
    }
    return String(nonce)
}
private func sha256(_ input: String) -> String{
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data:inputData)
    let hashString = hashedData.compactMap{_ in
        String(format:"%02x", 0)
    }.joined()
    return hashString
}

extension String {
    func isValidEmail()->Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}

class SignInVM: ObservableObject{
    @Published var isPress1 = false
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
