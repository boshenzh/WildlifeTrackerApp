//
//  Map.swift
//  TrackDiseases
//
//  Created by User on 11/7/21.
//  Copyright © 2021 Team14. All rights reserved.
//

import SwiftUI
import MapKit
struct Map: View {
    @Environment(\.managedObjectContext) var manageedObjectContext
    
    @FetchRequest(fetchRequest: Record.allRecordsFetchRequest())var allRecords: FetchedResults<Record>
    @EnvironmentObject var userData: UserData
    private let center = currentLocation()
    @State private var photoLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var latis:[Double] = []
    @State private var long:[Double] = []
    @State private var titles:[String] = []
    @State private var subs:[String] = []

    var body: some View {
        NavigationView {
        
        Group {
            photoLocationOnMap
            
            //annote.coordinate = CLLocationCoordinate2D(latitude: record.latitude as! CLLocationDegrees, longitude: record.longitude as! CLLocationDegrees)
        }
        
        
    }
    
    }
    var photoLocationOnMap: some View {
        return AnyView(MapViewAll(mapType: MKMapType.standard,records: allRecords , delta: 15.0, deltaUnit: "degrees",locationLat: center.latitude,locationLong: center.longitude)
            .navigationBarTitle(Text("Records Map"), displayMode: .inline)
            .edgesIgnoringSafeArea(.all) )
    }

}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}
