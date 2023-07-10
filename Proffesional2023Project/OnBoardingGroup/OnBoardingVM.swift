//
//  onBoardingVM.swift
//  ChampNation
//
//  Created by admin on 27.06.2023.
//

import Foundation
import SwiftUI

class OnBoardingVM : ObservableObject{
    @Published var nav: Nav
    @Published var items: [OnBoardingModel] = [
         OnBoardingModel(img: "frame1", text1: "Quick Delivery At Your\n             Doorstep", text2: "Enjoy quick pick-up and delivery to\n                your destination", color1: Color("Blue"), color2: Color.gray, color3: Color.gray),
         OnBoardingModel(img: "frame2", text1: "Flexible Payment", text2: "  Different modes of payment either\nbefore and after delivery without stress", color1: Color.gray, color2: Color("Blue"), color3: Color.gray),
         OnBoardingModel(img: "frame3", text1: "Real-time Tracking", text2: "  Track your packages/items from the\ncomfort of your home till final destination", color1: Color.gray, color2: Color.gray, color3: Color("Blue")),
    ]
    @Published var numerScreen = 0
    init(nav: Nav){
        self.nav = nav
    }
    func next(){
        if numerScreen < 2 {
            numerScreen += 1
        }
    }
    func skip(){
            nav.currentView = "signUp"
            UserDefaults.standard.set(true, forKey: "isOnbShowed")
    }
    func signUp(){
        nav.currentView = "signUp"
    }
}
