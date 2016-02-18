//
//  ViewController2.swift
//  Common Program
//
//  Created by Matt Gigliotti on 2/16/16.
//  Copyright © 2016 Matt Gigliotti. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var Instructions: UILabel!
    @IBOutlet weak var OpenMessage: UILabel!
    @IBOutlet weak var PathField: UITextField!
    @IBOutlet weak var Output: UILabel!
    @IBAction func SubmitPath(sender: AnyObject) {
        Output.text = " "
        var path = PathField.text
        Output.text = path

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

