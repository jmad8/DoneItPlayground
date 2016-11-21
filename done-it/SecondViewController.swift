//
//  SecondViewController.swift
//  done-it
//
//  Created by Justin Madsen on 11/4/16.
//  Copyright © 2016 Justin Madsen. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController {
    
    @IBOutlet weak var myLbl: UILabel!
    
    let conditionRef = FIRDatabase.database().reference().child("condition")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        conditionRef.observe(.value, with: { (snap: FIRDataSnapshot) in
            self.myLbl.text = snap.value as? String
        })
    }
    
}
