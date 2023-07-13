//
//  DataBaseManager.swift
//  SecondSupabase
//
//  Created by admin on 04.07.2023.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import Foundation
import Supabase
class DataBaseManager{
    static let shared = DataBaseManager()
    
    private init(){
        
    }
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://uwbxzymshoxjfjysqmdb.supabase.co")!,
                                supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3Ynh6eW1zaG94amZqeXNxbWRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODgyMDE3ODMsImV4cCI6MjAwMzc3Nzc4M30.YW9xOVJ0SgZH3aBDGb17SeGcmeXyFrTt6HnGvq08B-0")
    
//    созадние в бд
    func createToDoItem(item: ToDoPayload)async throws{
        let response = try await client.database.from("todos")
                                   .insert(values: item)
                                   .execute()
    }
    
    
//    получение из БД
    func fetchToDoItem(for uid: String)async throws -> [ToDo]{
        let response = try await client.database.from("todos")
          .select()
          .equals(column: "user_uid", value: uid) //по какому пользователю
          .order(column: "created_at", ascending: false) //сортировка по полю created_at
          .execute() //выполнение запроса на получение
        //декодирование данных
        let data = response.underlyingResponse.data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let todos = try decoder.decode([ToDo].self, from: data)
        return todos
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
