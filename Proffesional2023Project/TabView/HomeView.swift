//
//  HomeView.swift
//  Session12
//
//  Created by admin on 12.07.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var selected = 0
    @ObservedObject var nav: Nav
    init(nav: Nav){
        self.nav = nav
    }
    var body: some View {
        
        //нижняя навигация
        TabView(selection: $selected){
            HomeWindowView()
                .tabItem{
                    Image(selected == 0 ? "house" : "ho")
                    Text("home")
                }.tag(0)
            WalletWindowView()
                .tabItem{
                    Image(selected == 1 ? "walluse" : "wall")
                    Text("wallet")
                }.tag(1)
            TrackWindowView()
                .tabItem{
                    Image(selected == 2 ? "caruse" : "car")
                    Text("track")
                }.tag(2)
            ProfileWindowView()
                .tabItem{
                    Image(selected == 3 ? "profuse" : "prof")
                    Text("profile")
                      
                }.tag(3)
        }.accentColor(Color("Blue")) //цвет текста выделенного пункта
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(nav: Nav())
    }
}
