//
//  InfoFile.swift
//  Proffesional2023Project
//
//  Created by admin on 09.07.2023.
//

import Foundation

//должна соответствовать названия столбцов в таблице и типам данных
struct ToDo:Codable, Hashable{
    let id:Int
    let createdAt:String
    let text:String
    let userUid:String
}

//структура отправляемого объекта как понял
struct ToDoPayload: Codable{
    let text: String
    let userUid: String
    private enum CodingKeys: String, CodingKey{
        case text
        case userUid = "user_uid"
    }
}
class ToDoVM: ObservableObject{
    
    @Published var todos = [ToDo]() //массив получаемый из БД
    @Published var nav : Nav
    
    init(nav: Nav){
        self.nav = nav
    }
    
//    var mockData: [ToDoPayload] = [
//    ]
    
    //    функция проверяет, что все маленькие
    func createItems(text: String, uid:String) async throws{
        guard !todos.contains(where: { $0.text.lowercased() == text.lowercased()}) else{
            print("Already")
            throw NSError()
        }
        //формируем объект с текстом и uid
        let toDo = ToDoPayload(text: text, userUid: uid)
        //выполняем запрос на добавление из Database`manager, отправляя сформированный объект
        try await DataBaseManager.shared.createToDoItem(item: toDo)
    }
    
    @MainActor
    func fetchItems(for uid: String)async throws{
        print("user3" + uid)
        todos = try await DataBaseManager.shared.fetchToDoItem(for: uid)
    }
    
    
    //выход из авторизации, очистка пользователя и переход к экрану авторизации
    func logout()async throws{
        try await AuthManager.shared.signOut()
        nav.user.uid = ""
        nav.user.email = nil
        nav.currentView = "signIn"
    }
}
