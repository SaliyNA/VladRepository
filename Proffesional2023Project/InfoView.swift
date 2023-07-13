//
//  InfoView.swift
//  Proffesional2023Project
//
//  Created by admin on 12.07.2023.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var viewModel : ToDoVM
    
    init(nav: Nav){
        viewModel = ToDoVM(nav: nav)
    }
    
    @State var text:String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            LazyVStack{
                TextField("", text:$text)
                    .border(Color.black)
                
                // вывод первого элемента из полученного массива
                if !viewModel.todos.isEmpty {
                    Text("Balance " + viewModel.todos[0].text)
                }
                else{
                    Text("Balance 1676898")
                }
                
                // вывод всей таблицы
                ForEach(viewModel.todos, id:\.text){ todo in
                    Text(todo.text)
                }
                
                
                Button(action:{
                    Task{
                        //вызов функции на отправку текста на БД, uid сохранили в SignInVM при авторизации
                        try await viewModel.createItems(text:text,uid: viewModel.nav.user.uid)
                        //вызов функции на получение данных из БД по конкретному uid
                        try await viewModel.fetchItems(for: viewModel.nav.user.uid)
                        
                    }
                }){
                    Text("Create")
                }
                
                
                Button(action:{
                    Task{
                        do{
                            try await viewModel.logout()
//                            viewModel
//                            self.appUser = nil
                        } catch{
                            print("unable to sign out")
                        }
                    }
                    
                }){Text("LogOut")}
            }
        }.navigationTitle("To Do")
            .onAppear{
                Task{
                    //вызов функции на получение данных из БД по конкретному uid
                    try await viewModel.fetchItems(for: viewModel.nav.user.uid)
                    
                    dismiss()
                }
            }
    }
}

