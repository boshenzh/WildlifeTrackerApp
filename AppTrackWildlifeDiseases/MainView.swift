//
//  ContentView.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/18.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            AboutUs()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("About Us")
                }
            PictureTakeing()
                .tabItem {
                    Image(systemName: "arrow.up")
                    Text("Upload")
                }
            HistoryView()
                .tabItem{
                    Image(systemName: "doc.on.doc")
                    Text("History")
                }
            Map()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Map")
                }

            Setting()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .accentColor(Color("Burnt Orange"))
        

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
