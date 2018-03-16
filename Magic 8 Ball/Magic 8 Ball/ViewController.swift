//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Surya Chundru on 17/03/18.
//  Copyright © 2018 apolloappstudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ballImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askButtonPressed(_ sender: UIButton){
        rollBall()
    }
    
    func rollBall() {
        let imageIndex = arc4random_uniform(5) + 1
        
        print(imageIndex)
        
        ballImageView.image = UIImage(named: "ball\(imageIndex)")
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        rollBall()
    }
}

