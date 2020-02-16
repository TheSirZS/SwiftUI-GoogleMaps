//
//  SearchBar.swift
//  GoogleTest
//
//  Created by Diego Aragón Duarte on 15/02/20.
//  Copyright © 2020 Diego Aragón Duarte. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var query: String

    func makeCoordinator() -> SearchBar.Coordinator {
        return SearchBar.Coordinator(parent: self)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Buscar destino"
        searchBar.delegate = context.coordinator
        searchBar.isTranslucent = true
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .default
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = query
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        
        var parent: SearchBar

        init(parent: SearchBar) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.parent.query = searchText
        }
    }
}

