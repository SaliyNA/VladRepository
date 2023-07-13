//
//  SignInView.swift
//  ChampNation
//
//  Created by admin on 28.06.2023.
//

import SwiftUI
import Supabase
struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var user = AppUser(uid: "", email: nil)
    
    @ObservedObject var signInVM : SignInVM
    @State var isUser = false
    @State var isActive = false
    init(nav: Nav){
        signInVM = SignInVM(nav: nav)
    }
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Welcome back")
                    .foregroundColor(.black)
                // .fontWeight(.bold)
                //                .font(.custom("Roboto-Italic", size: 25))
                    .font(.custom("Roboto-BoldItalic", size: 25))
                Text("Fill in your email and password to continue")
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                Text("Email Address")
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                TextField("",text:$signInVM.signInModel.email)
                    .frame(width:342, height: 44)
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(1)
                    .background(Color.gray)
                    .cornerRadius(6)
                    .autocorrectionDisabled(true)
                    .alert(isPresented: $signInVM.isPress){
                        Alert(title: Text("Ошибка"),message: Text("Поля для ввода пусты"), dismissButton: .default(Text("OK")))}
                Text("Password")
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                
                ZStack{
                    if isActive == false{
                        SecureField("",text:$signInVM.signInModel.password)
                            .frame(width:342, height: 44)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color.gray)
                            .cornerRadius(6)
                            .autocorrectionDisabled(true)
                    }
                    else{
                        TextField("",text:$signInVM.signInModel.password)
                            .frame(width:342, height: 44)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color.gray)
                            .cornerRadius(6)
                            .autocorrectionDisabled(true)
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
                            let appUser = try await signInVM.SignInWithEmail(email: signInVM.signInModel.email, password: signInVM.signInModel.password)
                            //                                print("appUser =  \(appUser)")
//                                                            signInVM.nav.user.uid = appUser.uid
//                                                            signInVM.nav.user.email = appUser.email
                        }
                        
                        catch{
                            print("error signing in")
                        }
                    }
                }
                       
                       
                       
                ){
                    Text("Sign In")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: 342,height:46)
                        .background(Color("Blue"))
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
                .alert(isPresented: $signInVM.isPress1){
                    Alert(title: Text("Ошибка"),message: Text("Неверная форма ввода логина или пароля"), dismissButton: .default(Text("OK")))}
            }
        }
    }
    
    
}
