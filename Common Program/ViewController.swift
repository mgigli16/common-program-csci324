//
//  ViewController.swift
//  Common Program
//
//  Created by Matt Gigliotti on 2/16/16.
//  Copyright © 2016 Matt Gigliotti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var words: Set<String> = ["Dog", "Cat", "Horse", "People"]

    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var UserText: UITextField!
    
    @IBAction func Check(sender: AnyObject) {
        
        if words.contains(UserText.text!) {
            Progress.text = "Word was Found"
        }
        else {
            Progress.text = "Word was not Found"
        }
    
    }
    
    @IBAction func AddWord(sender: AnyObject) {
        words.insert(UserText.text!)
        Progress.text = "Word was Successfully added"
    }
    
    @IBOutlet weak var Progress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print("I can't wait to push this project to Github")
        //print("Test that I have updated successfully")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

