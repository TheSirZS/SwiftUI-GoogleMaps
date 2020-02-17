//
//  SearchBar.swift
//  GoogleTest
//
//  Created by Diego Aragón Duarte on 15/02/20.
//  Copyright © 2020 Diego Aragón Duarte. All rights reserved.
//

import SwiftUI
import GooglePlaces
import GoogleMaps

struct SearchBar: UIViewRepresentable {

    @Binding var query: String
    @Binding var mapView: GMSMapView
    @Binding var matchLocations: [GMSAutocompletePrediction]
    
    lazy var filter: GMSAutocompleteFilter = {
        let filter = GMSAutocompleteFilter()
        filter.country = "mx"
        filter.type = .address
        filter.type = .establishment
        return filter
    }()

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

            let neBoundsCorner = CLLocationCoordinate2D(latitude: 23.962542, longitude: -104.731688)
            let swBoundsCorner = CLLocationCoordinate2D(latitude: 24.151364, longitude: -104.504163)

            let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner, coordinate: swBoundsCorner)

            GMSPlacesClient().autocompleteQuery(self.parent.query, bounds: bounds, filter: self.parent.filter) { (results, error) in
                DispatchQueue.main.async {
                    guard error == nil else {
                        print("Autocomplete error \(error!.localizedDescription)")
                      return
                    }
                    if let results = results {
                        self.parent.matchLocations = results
                    }
                }
            }
        }
    }
}

