//
//  ContentView.swift
//  ChampNation
//
//  Created by admin on 27.06.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var nav = Nav()
 //   @State var appUser: AppUser? = nil
    var body: some View {
        VStack{
            switch nav.currentView {
            case "onBoarding" : OnBoardingView(nav: nav)
                
            case "signUp": SignUpView(nav: nav)
//            if let appUser = appUser{
            case "signIn": SignInView(nav: nav)
//            } else{
//                    }
            default: SignUpView(nav: nav)
                //OnBoardingView(nav: nav)
            }
        }.onAppear{
            Task{
                //self.appUser = try await AuthManager.shared.getCurrentSession()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
