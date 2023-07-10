//
//  SignInView.swift
//  ChampNation
//
//  Created by admin on 28.06.2023.
//

import SwiftUI
import Supabase
struct SignInView: View {
   // @Binding var appUser: AppUser?
  //  @StateObject var viewModel = SignInVM()
    @Environment(\.dismiss) var dismiss
    @ObservedObject var signInVM : SignInVM
    @StateObject var viewModel = ToDoVM()
    @State var text1 = ""
    @State var text2 = ""
    @State var isActive = false
    @State var isPress = false
    @State var isPress1 = false
    init(nav: Nav){
        signInVM = SignInVM(nav: nav)
    }
    var body: some View {
        VStack(alignment: .leading){
            ForEach(viewModel.todos, id:\.text){ todo in
                Text(todo.text)
            }
            Text("Welcome back")
                .foregroundColor(.black)
                .fontWeight(.bold)
//                .font(.system(size: 25))
                .font(.custom("Roboto-Black", size: 25))
            Text("Fill in your email and password to continue")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            Text("Email Address")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            TextField("",text:$text1)
                .frame(width:342, height: 44)
                .background(Color.white)
                .cornerRadius(6)
                .padding(1)
                .background(Color.gray)
                .cornerRadius(6)
                .autocorrectionDisabled(true)
                .alert(isPresented: $isPress){
                    Alert(title: Text("Ошибка"),message: Text("Поля для ввода пусты"), dismissButton: .default(Text("OK")))}
            Text("Password")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            ZStack{
                if isActive == false{
                    SecureField("",text:$text2)
                        .frame(width:342, height: 44)
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(1)
                        .background(Color.gray)
                        .cornerRadius(6)
                        .autocorrectionDisabled(true)
                }
                else{
                    TextField("",text:$text2)
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
                    
                    
                    if text1 == "" && text2 == ""{
                        self.isPress = true
                    }
                    else{
                        do{
                            
                            if signInVM.isFormValid(email: text1, password: text2){
                                try await viewModel.fetchItems(for: signInVM.nav.user.uid)
                                dismiss()
                                
                                try await viewModel.createItems(text: "Right now", uid: signInVM.nav.user.uid)
                                dismiss()
                                print("12345678")
                                let appUser = try await signInVM.SignInWithEmail(email: text1, password: text2)
                                print("appUser =  \(appUser)")
                                
                                
                                signInVM.nav.user.uid = appUser.uid
                                signInVM.nav.user.email = appUser.email
                                signInVM.nav.currentView = "onBoarding"
                                
                            }
                            else{
                                self.isPress1 = true
                            }
                            //                                self.appUser = appUser
                            //
                            //                                print("appUser =  \(self.appUser)")
                            //
                        }
                        
                        catch{
                            print("error signing in")
                        }
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
                .alert(isPresented: $isPress1){
                    Alert(title: Text("Ошибка"),message: Text("Неверная форма ввода логина или пароля"), dismissButton: .default(Text("OK")))}
            }
        }
    }



