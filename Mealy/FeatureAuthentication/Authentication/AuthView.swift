//
//  AuthView.swift
//  Mealy
//
//  Created by Bryan Khufa on 09/11/23.
//

import SwiftUI

struct AuthView<ViewModel>: View where ViewModel: AuthViewModel {
    
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var flowViewModel: FlowViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text(viewModel.screenTitle)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.bottom, 10)
            Group {
                TextField("Username", text: $viewModel.userName)
                SecureTextField(title: "Password", text: $viewModel.password)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray, lineWidth: 1.5)
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            
            Button {
                if viewModel.authenticateShouldNavigate() {
                    flowViewModel.navigateToMeal()
                }
            } label: {
                Text(viewModel.screenTitle)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            .padding()
            
            Button {
                viewModel.toggleAuthType()
            } label: {
                Text(viewModel.toggleButtonLabel)
            }
        }
        .alert(isPresented: $viewModel.shouldDisplayAlert) {
            Alert(
                title: Text(viewModel.alertMessage.title),
                message: Text(viewModel.alertMessage.message),
                dismissButton: .default(Text(viewModel.alertMessage.actionLabel), action: {
                    viewModel.alertMessage.action?()
                })
            )
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(viewModel: DefaultAuthViewModel(authType: .register, useCase: DefaultAuthUseCase(storage: KeyChainLocalStorage())))
    }
}
