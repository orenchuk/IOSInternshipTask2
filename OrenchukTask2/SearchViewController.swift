//
//  MealViewController.swift
//  OrenchukTask2
//
//  Created by Yevhen Orenchuk on 6/12/18.
//  Copyright © 2018 Yevhenii Orenchuk. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn

class SearchViewController: UIViewController, GIDSignInDelegate {
    
    var service: GTLRSheetsService?
    var scopes: [String]?
    
    var meal = Meal()
    var signedIn = false
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func searchButton() {
        if (signedIn) {
            parseMealList(day: "Понедельник")
        } else {
            showAlert(vc: self, title: "Login error", message: "")
        }
        
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ParsedResults") as? ParsedViewController {
//            if let name = nameField?.text {
//                vc.name = name
//            }
//            vc.salat = meal.salat
//            vc.soup = meal.soup
//            vc.main = meal.main
//            vc.garnish = meal.garnish
//            present(vc, animated: true)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            showAlert(vc: self, title: "Authentication Error", message: error.localizedDescription)
            self.service!.authorizer = nil
        } else {
            self.service!.authorizer = user.authentication.fetcherAuthorizer()
            signedIn = true
        }
    }
    
    func parseMealList(day: String) {
        let spreadsheetId = "1NrPDjp80_7venKB0OsIqZLrq47jbx9c-lrWILYJPS88"
        let range = "A1:M34"
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: range)
        if service != nil {
            service!.executeQuery(query, delegate: self, didFinish: #selector(parseSpreadsheet(ticket:finishedWithObject:error:)))
        } else {
            showAlert(vc: self, title: "Service Error", message: "service didn't execute")
        }
    }
    
    @objc func parseSpreadsheet(ticket: GTLRServiceTicket, finishedWithObject result : GTLRSheets_ValueRange, error : NSError?) {
        if let error = error {
            showAlert(vc: self, title: "Error", message: error.localizedDescription)
            return
        }
        
        let rows = result.values!
        
        if rows.isEmpty {
            showAlert(vc: self, title: "Parsing Error", message: "Spreadsheet is empty!")
            return
        }
        
        var args = ""
        for row in rows {
            if let value = row[0] as? String, let name = nameField.text {
                args += value
                if value == name {
                    showAlert(vc: self, title: "Founded", message: "yep")
                    for (index, element) in row.enumerated() {
                        print(element)
                        if element as? String == "1" {
                            if index > 0, index <= 3 {
                                meal.salat = rows[1][index] as! String
                            } else if index > 3, index <= 6 {
                                meal.soup = rows[1][index] as! String
                            } else if index > 6, index <= 9 {
                                meal.main = rows[1][index] as! String
                            } else if index > 9, index <= 12 {
                                meal.garnish = rows[1][index] as! String
                            }
                        }
                    }
                    showAlert(vc: self, title: "Results:", message: "\(meal.salat) - \(meal.soup) - \(meal.main) - \(meal.garnish)")
                    return
                }
                showAlert(vc: self, title: "no one was founded", message: args)
            }
        }
        
    }

}

struct Meal {
    var salat = ""
    var soup = ""
    var main = ""
    var garnish = ""
}
