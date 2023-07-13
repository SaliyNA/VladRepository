//
//  AuthMng.swift
//  Proffesional2023Project
//
//  Created by admin on 08.07.2023.
//

import Foundation
import Supabase

class AuthManager{
    
    static let shared = AuthManager()
    private init(){
    }
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://uwbxzymshoxjfjysqmdb.supabase.co")!,
                                supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3Ynh6eW1zaG94amZqeXNxbWRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODgyMDE3ODMsImV4cCI6MjAwMzc3Nzc4M30.YW9xOVJ0SgZH3aBDGb17SeGcmeXyFrTt6HnGvq08B-0")
    
    func getCurrentSession() async throws -> AppUser{
        let session = try await client.auth.session
        print(session)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser{
        let regAuthResponse = try await client.auth.signUp(email: email, password: password)
        guard let session = regAuthResponse.session else{
            print("no session when registering user")
            throw NSError()
        }
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    
    func signInWithEmail(email: String, password: String) async throws -> AppUser{
        let session = try await client.auth.signIn(email: email, password: password)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    
    //выход пользователя
    func signOut() async throws{
        try await client.auth.signOut()
    }
}
