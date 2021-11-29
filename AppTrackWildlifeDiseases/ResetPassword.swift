//
//  ResetPassword.swift
//  TrackDiseases
//
//  Created by User on 10/24/21.
//  Copyright © 2021 Team14. All rights reserved.
//

import SwiftUI

struct ResetPassword: View {
    @State private var showEnteredValues = false
    @State private var showUnmatchedPasswordAlert = false
    
    @State private var answerEntered = ""
    var listOfAllquestions = ["In what city or town did your mother and father meet?", "In what city were you born?","What is the name of your favorite pet?","What is your mother's maiden name?","What is the name of the first school you attended?","What was the make of your first car?", "What high school did you attend?","what is your mother's maiden name?","In what city or town were you born?", "What was your favorite food as a child?"]

    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            Form {
                Section(header: Text("Show/hide entered values")) {
                    Toggle(isOn: $showEnteredValues){
                        Text("Show Entered Values")
                    }
                }
                .textCase(nil)

                Section(header:Text("Security Question")){
                    let question = UserDefaults.standard.string(forKey: "Question")
                    Text("\(question ?? "")")
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200, height:40)
                        .padding()
                        .font(.system(size:14))
                }
                .textCase(nil)

                if self.showEnteredValues {
                    
                    Section(header:Text("Enter Answer")){
                        HStack{
                            
                            TextField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200, height:20)
                                .padding()
                                .textCase(nil)

                            Button(action: {
                                self.answerEntered = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                        
                    }
                    .textCase(nil)

                    
                    
                } else {
                    
                    Section(header:Text("Enter Answer"))
                    {
                        HStack{
                            SecureField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200, height: 20)
                                .padding()
                                .textCase(nil)

                            Button(action: {
                                self.answerEntered = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                            
                        }
                    }
                    .textCase(nil)

                }
                if !answerEntered.isEmpty {
                    let answerReal = UserDefaults.standard.string(forKey: "Answer")
                    
                    if answerEntered ==  answerReal {
                        Section(header:Text("Go to settings to reset password")){
                            NavigationLink(
                                destination: Setting()){
                                HStack{
                                    Image(systemName: "gear")
                                        .foregroundColor(.blue)
                                    Text("Show Setings")
                                }
                            }
                        }
                        .textCase(nil)

                    } else {
                        Section(header: Text("Incorrect answer")) {
                            Text("Answer to security question is incorrect")
                        }
                        .textCase(nil)

                    }
                    
                }
            }
            .navigationBarTitle(Text("Password Reset"), displayMode: .inline)
            .font(.system(size: 14))
            .padding()
            
    }   // End of ZStack
        .accentColor(Color("Burnt Orange"))


}   // End of var

/*
 --------------------------
 MARK: - Password Set Alert
 --------------------------
 */
var passwordSetAlert: Alert {
    Alert(title: Text("Password Set!"),
          message: Text("Password you entered is set to unlock the app!"),
          dismissButton: .default(Text("OK")) )
}

/*
 --------------------------------
 MARK: - Unmatched Password Alert
 --------------------------------
 */
var unmatchedPasswordAlert: Alert {
    Alert(title: Text("Unmatched Password!"),
          message: Text("Two entries of the password must match!"),
          dismissButton: .default(Text("OK")) )
}
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword()
    }
}


