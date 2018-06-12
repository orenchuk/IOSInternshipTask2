//
//  ShowAlert.swift
//  OrenchukTask2
//
//  Created by Yevhen Orenchuk on 6/12/18.
//  Copyright © 2018 Yevhenii Orenchuk. All rights reserved.
//

import UIKit

func showAlert(vc: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
    alert.addAction(ok)
    vc.present(alert, animated: true, completion: nil)
}
