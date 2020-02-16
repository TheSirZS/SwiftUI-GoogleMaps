//
//  GoogleMap.swift
//  GoogleTest
//
//  Created by Diego Aragón Duarte on 15/02/20.
//  Copyright © 2020 Diego Aragón Duarte. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct Map: UIViewRepresentable {
    
    let marker : GMSMarker = GMSMarker()

    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        mapView.padding = padding

        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
}

