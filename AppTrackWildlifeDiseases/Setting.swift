//
//  Setting.swift
//  TrackDiseases
//
//  Created by User on 10/24/21.
//  Copyright © 2021 Team14. All rights reserved.
//

import SwiftUI

struct Setting: View {
    @State private var showEnteredValues = false
    
    @State private var answerEntered = ""
    @State private var passwordEntered = ""
    @State private var passwordVerified = ""
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    @State private var selectedIndex = 0
    var listOfAllquestions = ["In what city or town did your mother and father meet?", "In what city were you born?","What is the name of your favorite pet?","What is your mother's maiden name?","What is the name of the first school you attended?","What was the make of your first car?", "What high school did you attend?","what is your mother's maiden name?","In what city or town were you born?", "What was your favorite food as a child?"]

    var body: some View {
        NavigationView{
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            Form {
                Section(header: Text("Show/hide entered values")) {
                    Toggle(isOn: $showEnteredValues){
                        Text("Show Entered Values")
                    }
                }
                .textCase(nil)

                Section(header: Text("Select a security question")) {
                    Picker("Selected:", selection: $selectedIndex) {
                        ForEach(0 ..< listOfAllquestions.count, id: \.self) {
                            Text(listOfAllquestions[$0])
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500,alignment: .center)
                    
                }
                .textCase(nil)


                if self.showEnteredValues {
                    
                    Section(header:Text("Enter answer to selected security question")){
                        HStack{
                            TextField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height:20)
                                .padding()
                                .autocapitalization(.none)

                                
                                
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
                    
                    Section(header:Text("Enter answer to selected security question"))
                    {
                        HStack{
                            SecureField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height: 20)
                                .padding()
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
                if self.showEnteredValues {
                    
                    Section(header:Text("Enter Password")){
                        HStack{
                            TextField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height:20)
                                .padding()
                                .autocapitalization(.none)

                            Button(action: {
                                self.passwordEntered = ""
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                    }
                    .textCase(nil)

                    
                    
                } else {
                    
                    Section(header:Text("Enter Password"))
                    {
                        HStack{
                            SecureField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height:20)
                                .padding()
                                .textCase(nil)

                            Button(action: {
                                self.passwordEntered = ""
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                            
                            
                        }

                    }
                    .textCase(nil)

                }
                if self.showEnteredValues {
                    
                    Section(header:Text("Verify Password")){
                        HStack{
                            TextField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height:20)
                                .padding()
                                .autocapitalization(.none)
                            Button(action: {
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                    }
                    .textCase(nil)

                    
                } else {
                    
                    Section(header:Text("Verify Password"))
                    {
                        HStack{
                            SecureField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height:20)
                                .padding()
                            Button(action: {
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                            
                        }
                    }
                    .textCase(nil)

                }
                Section(header:Text("Set password")){
                    Button(action: {
                        if !passwordEntered.isEmpty {
                            if passwordEntered == passwordVerified {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                // Store the password in the user’s defaults database under the key "Password"
                                UserDefaults.standard.set(self.passwordEntered, forKey: "Password")
                                UserDefaults.standard.set(listOfAllquestions[selectedIndex], forKey: "Question")
                                UserDefaults.standard.set(self.answerEntered, forKey: "Answer")


                                self.answerEntered = ""
                                self.passwordEntered = ""
                                self.passwordVerified = ""
                                self.showPasswordSetAlert = true
                            } else {
                                self.showUnmatchedPasswordAlert = true
                            }
                        }
                    }) {
                        Text("Set Password to Unlock App")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    .alert(isPresented: $showUnmatchedPasswordAlert, content: { self.unmatchedPasswordAlert })
                    .alert(isPresented: $showPasswordSetAlert, content: { self.passwordSetAlert })
                }
                .textCase(nil)

                                
            }   // End of VStack
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            .font(.system(size: 14))
            
        }   // End of ZStack
        }
        
    }
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

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
