//
//  ParsedViewController.swift
//  OrenchukTask2
//
//  Created by Yevhen Orenchuk on 6/12/18.
//  Copyright © 2018 Yevhenii Orenchuk. All rights reserved.
//

import UIKit

class ParsedViewController: UIViewController {
    
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var salatLabel: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var mainDishLabel: UILabel!
    @IBOutlet weak var garnishLabel: UILabel!
    
    var weekday = ""
    var name = ""
    var salat = ""
    var soup = ""
    var main = ""
    var garnish = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        weekdayLabel.text = weekday
        nameLabel.text = name
        salatLabel.text = salat
        soupLabel.text = soup
        mainDishLabel.text = main
        garnishLabel.text = garnish
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
