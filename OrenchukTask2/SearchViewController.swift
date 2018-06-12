//
//  MealViewController.swift
//  OrenchukTask2
//
//  Created by Yevhen Orenchuk on 6/12/18.
//  Copyright © 2018 Yevhenii Orenchuk. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST

class SearchViewController: UIViewController {
    
    var service: GTLRSheetsService?
    var meal = Meal()
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func searchButton() {
        
        parseMealList(day: "Понедельник")
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ParsedResults") as? ParsedViewController {
            if let name = nameField?.text {
                vc.name = name
            }
            vc.salat = meal.salat
            vc.soup = meal.soup
            vc.main = meal.main
            vc.garnish = meal.garnish
            present(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func parseMealList(day: String) {
        let spreadsheetId = "1NrPDjp80_7venKB0OsIqZLrq47jbx9c-lrWILYJPS88"
        let range = "A1:M34"
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: range)
        service?.executeQuery(query, delegate: self, didFinish: #selector(parseSpreadsheet(ticket:finishedWithObject:error:)))
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
        for row in rows {
            if let value = row[0] as? String, let name = nameField.text {
                if value == name {
                    for (index, element) in row.enumerated() {
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
                    return
                }
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
