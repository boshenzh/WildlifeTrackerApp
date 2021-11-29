//
//  History.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import SwiftUI
import MapKit
struct HistoryView: View {
    @Environment(\.managedObjectContext) var manageedObjectContext
    
    @FetchRequest(fetchRequest: Record.allRecordsFetchRequest())var allRecords: FetchedResults<Record>
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        NavigationView {
            //Group {
                //if !allRecords.isEmpty {
                    List {
                        ForEach(self.allRecords) { rec in
                            NavigationLink(destination: HistoryDetails(record: rec)) {
                                ListItem(record: rec)

                            }
                        }
                    }
                    .navigationBarTitle(Text("History"))

                    
                //} else {
                //    Text("You have not uploaded any records yet")
                //}
            //}
            
            
        }
        
    }
    
    
}

struct history_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
