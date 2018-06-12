//
//  ViewController.swift
//  OrenchukTask2
//
//  Created by Yevhen Orenchuk on 6/11/18.
//  Copyright © 2018 Yevhenii Orenchuk. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    
    private let service = GTLRSheetsService()
    let signInButton = GIDSignInButton()
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            showAlert(vc: self, title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            
            if let vc = (self.storyboard?.instantiateViewController(withIdentifier: "searchName") as? SearchViewController) {
                vc.service = service
                vc.scopes = scopes
                present(vc, animated: true)
            } else {
                showAlert(vc: self, title: "Search problem", message: "")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        // Add the sign-in button
        signInButton.frame = CGRect(x: 0, y: 300, width: 300, height: 48)
        signInButton.center = view.center
        signInButton.style = GIDSignInButtonStyle.wide
        view.addSubview(signInButton)
    }
}

