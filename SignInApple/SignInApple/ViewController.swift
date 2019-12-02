//
//  ViewController.swift
//  SignInApple
//
//  Created by shenjie on 2019/12/2.
//  Copyright © 2019 shenjie. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @available(iOS 13.0, *)
    @IBAction func appleSignInAction(_ sender: Any) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        authorizationRequest(requests: [request])
    }
    
    @available(iOS 13.0, *)
    func signOut() {
        
    }
    
    @available(iOS 13.0, *)
    func refresh() {
        
    }
    
//    @available(iOS 13.0, *)
//    func check() -> Int {
//        var result: ASAuthorizationAppleIDProvider.CredentialState = .notFound
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
////        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
////            result = credentialState
////        }
//        return result.rawValue
//    }
    
    @available(iOS 13.0, *)
    func authorizationRequest(requests: [ASAuthorizationRequest]) {
        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

@available(iOS 13.0, *)
extension ViewController: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
     func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userId = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("\(userId)|\(String(describing: fullName))|\(email)")
            
        }else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("\(username)|\(password)")
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error){
        
    }
}

@available(iOS 13.0, *)
extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

