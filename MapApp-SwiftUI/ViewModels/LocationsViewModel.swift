//
//  LocationsViewModel.swift
//  MapApp-SwiftUI
//
//  Created by Abdul Majid Shaikh on 15/06/26.
//
 
import Foundation
internal import Combine
import MapKit
import SwiftUI

class LocationsViewModel : ObservableObject {
    
    //All Loaded Locations
    @Published var locations : [Location]
    
    //Current Location on Map...
    @Published var mapLocation : Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Current region on Map
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    
    @Published var showLocationList : Bool = false
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut){
            showLocationList = !showLocationList
        }
    }
    
    func showNextLocation(location : Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        //get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find the current index in locations")
            return
        }
        
        //Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        
        //Next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}


