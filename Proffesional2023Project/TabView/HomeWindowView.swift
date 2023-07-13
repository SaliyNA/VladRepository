//
//  HomeWindowView.swift
//  Session12
//
//  Created by admin on 12.07.2023.
//

import SwiftUI

struct HomeWindowView: View {
    @State var isOnn = false
    var body: some View {
        VStack{
            Text("Profile")
            HStack{
                Toggle(isOn: $isOnn){
                    Text("Enable dark Mode")
                }
            }
            CustomProfileSettings(img: "", name: "1", descr: "2")
            CustomProfileSettings(img: "", name: "11", descr: "22")
            CustomProfileSettings(img: "", name: "111", descr: "222")
            CustomProfileSettings(img: "", name: "1111", descr: "2222")
            CustomProfileSettings(img: "", name: "11111", descr: "22222")
            CustomProfileSettings(img: "", name: "111111", descr: "222222")
        }
    }
}

struct HomeWindowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWindowView()
    }
}
