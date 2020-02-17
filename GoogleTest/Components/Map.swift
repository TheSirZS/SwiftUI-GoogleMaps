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
    
    @Binding var mapView: GMSMapView
    @Binding var manager: CLLocationManager
    
    func makeCoordinator() -> Map.Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: Self.Context) -> GMSMapView {
        
        self.mapView.delegate = context.coordinator
        let padding = UIEdgeInsets(top: 100, left: 0, bottom: 370, right: 0)
        self.mapView.padding = padding
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            self.manager.startUpdatingLocation()
            self.mapView.isMyLocationEnabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
                if let user = self.manager.location {
                    let camera = GMSCameraPosition.camera(withLatitude: user.coordinate.latitude, longitude: user.coordinate.longitude, zoom: 15.0)
                    self.mapView.animate(to: camera)
                }
            })
        }
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: Map
        
        init(_ parent: Map) {
            self.parent = parent
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
                self.parent.mapView.animate(to: camera)
                self.parent.manager.stopUpdatingLocation()
            }
        }
    }
}

