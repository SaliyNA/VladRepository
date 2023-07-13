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
            case "signIn": SignInView(nav: nav)
            case "home": HomeView(nav: nav)
            case "infoView": InfoView(nav: nav)
            default: SignInView(nav: nav)
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
