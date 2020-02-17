//
//  SearchView.swift
//  GoogleTest
//
//  Created by Diego Aragón Duarte on 17/02/20.
//  Copyright © 2020 Diego Aragón Duarte. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct SearchView: View {
    
    @Binding var query: String
    @Binding var mapView: GMSMapView
    @Binding var matchLocations: [GMSAutocompletePrediction]
    @Binding var isTapped: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(query: self.$query, mapView: self.$mapView, matchLocations: self.$matchLocations).padding(.horizontal, 5)
                List {
                    if self.query != "" && self.matchLocations.count > 0 {
                        ForEach(self.matchLocations.filter {
                            self.query.isEmpty ? true : "\($0)".localizedStandardContains(self.query)
                        }, id: \.self) { location in
                            Button(action: {
                                
                            }) {
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.primary)
                                        .font(Font.system(size: 20, weight: .semibold)).padding(5)
                                    VStack(alignment: .leading) {
                                        Text("\(location.attributedPrimaryText.string)").font(.headline).foregroundColor(.primary).lineLimit(1)
                                        Text("\(location.attributedSecondaryText!.string)").font(.subheadline).foregroundColor(.secondary).lineLimit(1)
                                    }
                                }
                            }
                        }
                    }
                }
            }.navigationBarTitle("Buscar").navigationBarItems(trailing: HStack {
                Button(action: {
                    self.isTapped = false
                    self.query = ""
                }) {
                    Image(systemName: "multiply").imageScale(.large).foregroundColor(.primary)
                }
            })
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView(
                query: MapView().$query,
                mapView: MapView().$mapView,
                matchLocations: MapView().$matchLocations,
                isTapped: MapView().$isTapped
            ).environment(\.colorScheme, .light)
            
            SearchView(
                query: MapView().$query,
                mapView: MapView().$mapView,
                matchLocations: MapView().$matchLocations,
                isTapped: MapView().$isTapped
            ).environment(\.colorScheme, .dark)
        }
    }
}
