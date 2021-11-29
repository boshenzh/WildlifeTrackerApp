//
//  ContentView.swift
//  TrackDiseases
//
//  Created by User on 10/24/21.
//  Copyright © 2021 Team14. All rights reserved.
//

import SwiftUI
import LocalAuthentication
struct ContentView: View {
    @State private var isUnlocked = false
    
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        if userData.userAuthenticated || isUnlocked {
            return AnyView(MainView())
                .onAppear(perform: authenticate)
             
        } else {
            return AnyView(LoginView())
                .onAppear(perform: authenticate)
        }
         
    }
    
    //this Function implement the face id authentification. change state variable isUnblocked is successfully matched the face
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                DispatchQueue.main.async{
                    if success{
                        self.isUnlocked = true
                    }
                    else{
                        print("not match")
                    }
                }
            }
        }
        else{
            //no biometrics
            print("no biometrics")
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
