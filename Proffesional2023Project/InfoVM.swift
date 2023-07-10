//
//  InfoFile.swift
//  Proffesional2023Project
//
//  Created by admin on 09.07.2023.
//

import Foundation
struct ToDo:Codable, Hashable{
    let id:Int
    let createdAt:String
    let text:String
    let userUid:String
}
struct ToDoPayload: Codable{
    let text: String
    let userUid: String
    private enum CodingKeys: String, CodingKey{
        case text
        case userUid = "user_uid"
    }
}
class ToDoVM: ObservableObject{
    
    @Published var todos = [ToDo]()
    var mockData: [ToDoPayload] = [
    ]
    
    func createItems(text: String, uid:String) async throws{
        guard !todos.contains(where: { $0.text.lowercased() == text.lowercased()}) else{
            print("Already")
            throw NSError()
        }
        let toDo = ToDoPayload(text: text, userUid: uid)
        try await DataBaseManager.shared.createToDoItem(item: toDo)
    }
    @MainActor
    func fetchItems(for uid: String)async throws{
        todos = try await DataBaseManager.shared.fetchToDoItem(for: uid)
    }
}
