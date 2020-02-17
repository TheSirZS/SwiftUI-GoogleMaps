//
//  ContentView.swift
//  GoogleTest
//
//  Created by Diego Aragón Duarte on 15/02/20.
//  Copyright © 2020 Diego Aragón Duarte. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct MapView: View {
    
    @State var query: String = ""
    @State var mapView = GMSMapView()
    @State var manager = CLLocationManager()
    @State var matchLocations = [GMSAutocompletePrediction]()
    @State var isTapped: Bool = false
    
    var body: some View {
        ZStack {
            Map(mapView: $mapView, manager: $manager)
            VStack {
                Spacer()
                BottomSheet(isTapped: $isTapped) {
                    VStack {
                        Handle().padding(5)
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Bienvenido").font(.caption).foregroundColor(.secondary)
                                Text("¿A donde iras?").font(.system(size: 25)).foregroundColor(.primary).fontWeight(.semibold)
                            }
                            Spacer()
                        }.padding(.horizontal)
                        SearchBar(query: self.$query, mapView: self.$mapView, matchLocations: self.$matchLocations).padding(.horizontal, 5).simultaneousGesture(TapGesture().onEnded {
                            self.isTapped = true
                        })
                        List {
                            Button(action: {
                                
                            }) {
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.primary)
                                        .font(Font.system(size: 20, weight: .semibold)).padding(5)
                                    VStack(alignment: .leading) {
                                        Text("Iniciar un viaje").font(.headline).foregroundColor(.primary).lineLimit(1)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }.sheet(isPresented: $isTapped) {
                    SearchView(query: self.$query, mapView: self.$mapView, matchLocations: self.$matchLocations, isTapped: self.$isTapped)
                }
            }
        }.edgesIgnoringSafeArea(.vertical)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapView()
               .environment(\.colorScheme, .light)

            MapView()
               .environment(\.colorScheme, .dark)
        }
    }
}
