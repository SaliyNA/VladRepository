//
//  CustomProfileSettings.swift
//  Proffesional2023Project
//
//  Created by admin on 13.07.2023.
//

import SwiftUI

struct CustomProfileSettings: View {
    var img: String
    var name:String
     var descr: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width:342 ,height: 62)
                .foregroundColor(.white)
                .shadow(radius: 1)
            HStack{
                Image(img)
                VStack{
                    Text(name)
                    Text(descr)
                }
                Spacer()
                Button(action:{}){
                    Image("arrow")
                    Text(">")
                        .foregroundColor(.blue)
                }
            }
        }.frame(width:342 ,height: 62)
    }
}
