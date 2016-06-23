//
//  ViewController.swift
//  Buzzer
//
//  Created by Asma Harbi on 2016-05-04.
//  Copyright © 2016 Asma Harbi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playGame(sender: UIButton) {
        print("HELLO!")
    }
    
    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue) {
        
    }
    

}

