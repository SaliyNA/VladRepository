//
//  Main.swift
//  Proffesional2023Project
//
//  Created by admin on 27.06.2023.
//

import SwiftUI

struct SignUpView: View {
    @State var text1 = ""
    @State var text2 = ""
    @State var text3 = ""
    @State var text4 = ""
    @ObservedObject var signUpVM : SingUpVM
    @State var isActive = false
    init(nav: Nav){
        signUpVM = SingUpVM(nav: nav)
    }
    var body: some View {
        VStack(alignment: .leading){
            Text("Create an account")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.system(size: 25))
            Text("Complete the sign up process to get started")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            Text("Full Name")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            TextField("",text:$text1)
                .frame(width:342, height: 44)
                .background(Color.white)
                .cornerRadius(6)
                .padding(1)
                .background(Color.gray)
                .cornerRadius(6)
                
            Text("Phone Number")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            TextField("",text:$text2)
                .frame(width:342, height: 44)
                .background(Color.white)
                .cornerRadius(6)
                .padding(1)
                .background(Color.gray)
                .cornerRadius(6)
                
            Text("Email Address")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            TextField("",text:$text3)
                .frame(width:342, height: 44)
                .background(Color.white)
                .cornerRadius(6)
                .padding(1)
                .background(Color.gray)
                .cornerRadius(6)
            VStack(alignment:.leading){
            Text("Password")
                .foregroundColor(.gray)
                .font(.system(size: 15))
                ZStack{
                    if isActive == false{
                        SecureField("",text:$text4)
                            .frame(width:342, height: 44)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color.gray)
                            .cornerRadius(6)
                    }
                    else{
                        TextField("",text:$text4)
                            .frame(width:342, height: 44)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color.gray)
                            .cornerRadius(6)
                    }
                        Button(action:{
                            self.isActive.toggle()
                        }){
                            Image("eye")
                                .resizable()
                                .frame(width: 14,height:14)
                        }.padding(.leading, 300)
                    
                }

            
                Button(action:{
                    Task{
                        do{
                            let appUser = try await signUpVM.registerNewUserWithEmail(email: text3, password: text4)
                                print("appUser =  \(appUser)")
//                            signUpVM.nav.user.uid = appUser.uid
//                            signUpVM.nav.user.email = appUser.email
                                signUpVM.nav.currentView = "signIn"
                                
//                                self.appUser = appUser
//
//                                print("appUser =  \(self.appUser)")
       //
                        } catch{
                            print("error signing in")
                        }
                    }
                }){
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 342,height:46)
                        .background(Color("Blue"))
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
            }
        }.navigationBarHidden(true)
    }
}


