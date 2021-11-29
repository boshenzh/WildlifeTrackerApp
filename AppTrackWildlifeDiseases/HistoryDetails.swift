//
//  HistoryDetails.swift
//  TrackDiseases
//
//  Created by User on 11/28/21.
//  Copyright © 2021 Team14. All rights reserved.
//


import SwiftUI
import MapKit

struct HistoryDetails: View {
    @State private var location = ""
    @State private var country = ""

    let record:Record
   
    @FetchRequest(fetchRequest: Record.allRecordsFetchRequest())var allRecords: FetchedResults<Record>
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        Form{
            Section(header: Text("Date")) {
                Text("\(record.date ?? "")")
            }
            Section(header: Text("Photo")) {
                // This public function is given in UtilityFunctions.swift
                getImageFromBinaryData(binaryData: record.photo!.photo!, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section(header: Text("Level of Expertise")) {
                Text(record.choice ?? "")
            }
            Section(header: Text("Contact Information")) {
                Text(record.contactInformation ?? "")
            }
            Section(header: Text("Notes")) {
                Text(record.additionalInformation ?? "")
            }
            Section(header: Text("Geographical Location")) {
                Text("Long: \(formatter(number: Double(truncating: record.longitude ?? 0))) Lat: \(formatter(number: Double(truncating: record.latitude ?? 0)))")
            }
            Section(header: Text("Location")) {
                Text(location )
            }


        }
        .onAppear(perform: {
            
            getLocation()
        })
        .navigationBarTitle(Text(country))
        .font(.system(size: 14))

    }   // End of body
    func getLocation() {
//        var r: String = ""
//        let sem = DispatchSemaphore(value: 0)
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: Double(truncating: record.latitude!), longitude: Double(truncating: record.longitude!))) {
            (place, error) in
            location = (place?.first?.country ?? "") + ", " + (place?.first?.administrativeArea ?? "") + ", " + (place?.first?.locality ?? "") + ", " + (place?.first?.subLocality ?? "")  + "\n" + (place?.first?.name ?? "") + ", " + (place?.first?.postalCode ?? "")
            country = (place?.first?.country ?? "") + ", " + (place?.first?.administrativeArea ?? "")
        }
        
    }
}
 
