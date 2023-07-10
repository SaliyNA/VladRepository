//
//  ContentView.swift
//  Proffesional2023Project
//
//  Created by admin on 27.06.2023.
//

import SwiftUI

    
    
   
struct OnBoardingView: View {
    @State var isActive = false
    @State var isSkip = false
    @ObservedObject var onBoardingVM: OnBoardingVM
    init(nav: Nav){
        onBoardingVM = OnBoardingVM(nav: nav)
    }
    var body: some View {
        NavigationView{
        ZStack{
                VStack {
                    Image(onBoardingVM.items[onBoardingVM.numerScreen].img)
                        .aspectRatio(contentMode: .fit)
                    Text(onBoardingVM.items[onBoardingVM.numerScreen].text1)
                        .foregroundColor(Color("Blue"))
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    Text(onBoardingVM.items[onBoardingVM.numerScreen].text2)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .padding(.bottom, 20)
                    HStack{
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(onBoardingVM.items[onBoardingVM.numerScreen].color1)
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(onBoardingVM.items[onBoardingVM.numerScreen].color2)
                        Circle()
                            .frame(width: 10)
                            .foregroundColor(onBoardingVM.items[onBoardingVM.numerScreen].color3)
                    }.padding(.top, 40)
                    if  onBoardingVM.numerScreen < 2 {
                        HStack{
                            Button(action:{
                                onBoardingVM.skip()
                            }){
                                Text("Skip")
                                    .frame(width: 75, height:38)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding(1)
                                    .background(Color("Blue"))
                                    .cornerRadius(10)
                            }.padding(.leading, 20)
                                .padding(.trailing, 150)
                            Button(action:{
                                onBoardingVM.next()
                            }){
                                Text("Next")
                                    .foregroundColor(.white)
                                    .frame(width: 75, height:38)
                                    .background(Color("Blue"))
                                    .cornerRadius(10)
                            }.padding(.trailing, 20)
                        }.padding(.top, 50)
                    }
                    else{
                        Button(action:{onBoardingVM.signUp()}){
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width:342,height:46)
                                .background(Color("Blue"))
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}
