//
//  ContentView.swift
//  GoogleTest
//
//  Created by Diego Aragón Duarte on 15/02/20.
//  Copyright © 2020 Diego Aragón Duarte. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var query: String = ""
    
    var body: some View {
        ZStack {
            Map()
            VStack {
                Spacer()
                BottomSheet {
                    VStack {
                        Handle().padding(5)
                        SearchBar(query: self.$query).padding(.top, 5)
                        Spacer()
                    }
                }
            }
        }.edgesIgnoringSafeArea(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
               .environment(\.colorScheme, .light)

            ContentView()
               .environment(\.colorScheme, .dark)
        }
    }
}
