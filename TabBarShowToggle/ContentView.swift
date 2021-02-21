//
//  ContentView.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel = ContentViewModel(featureToggleService: .shared)
    @State var selected = 0
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                if self.selected == 0 {
                    GeometryReader { proxy in
                        Text("Hello, World! Feature")
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height, alignment: .center)
                    }
                } else if self.selected == 1 {
                    GeometryReader { proxy in
                        Text("Whislist")
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height, alignment: .center)
                    }
                } else {
                    GeometryReader { proxy in
                        Text("Cart")
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height, alignment: .center)
                    }
                }
            }.background(Color("Color")).edgesIgnoringSafeArea(.all)
            
            if viewModel.isEnableAddItem {
                FloatingTabBar(viewModel: self.viewModel, selected: self.$selected)
            }
        }
    }
}


struct FloatingTabBar: View {
    
    @ObservedObject var viewModel: ContentViewModel
    @Binding var selected: Int
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action: {
                self.selected = 0
            }, label: {
                Image(systemName: "house")
                    .foregroundColor(self.selected == 0 ? .black : .gray)
                    .padding(.horizontal)
            })
            
            Spacer()
            
            Button(action: {
                self.selected = 1
            }, label: {
                Image(systemName: "list.bullet.below.rectangle")
                    .foregroundColor(self.selected == 1 ? .black : .gray)
                    .padding(.horizontal)
            })
            
            Spacer()
            
            if viewModel.isEnableAddCategory {
                Button(action: {
                    self.selected = 2
                }, label: {
                    Image(systemName: "cart")
                        .foregroundColor(self.selected == 2 ? .black : .gray)
                        .padding(.horizontal)
                })
            }
            
            Spacer()
            
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 35)
        .background(Color.white)
        .clipShape(Capsule())
        .padding(22)
        .shadow(radius: 10)
    }
}
