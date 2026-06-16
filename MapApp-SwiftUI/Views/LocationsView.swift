//
//  LocationsView.swift
//  MapApp-SwiftUI
//
//  Created by Abdul Majid Shaikh on 15/06/26.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm : LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                
                ZStack {
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(color: Color.black.opacity(0.3),  radius: 20)
                                .padding(20)
                                .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                        removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
    }
}


extension LocationsView {
    
    private var header : some View {
        VStack {
            
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + "," + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees:
                                                    vm.showLocationList ? 180 : 0 ))
                    }
            }
            
            if vm.showLocationList {
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
