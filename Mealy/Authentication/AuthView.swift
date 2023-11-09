//
//  AuthView.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import SwiftUI

struct AuthView: View {
    
    @State var userName: String = ""
    @State var passWord: String = ""
    let screenName: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(screenName)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.bottom, 10)
            Group {
                TextField("Username", text: $userName)
                TextField("Password", text: $passWord)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 1.5)
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            
            Button {
                
            } label: {
                Text(screenName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(screenName: "Register")
    }
}
