//
//  AnswerInputViewController.swift
//  Buzzer
//
//  Created by Asma Harbi on 2016-05-30.
//  Copyright © 2016 Asma Harbi. All rights reserved.
//

import UIKit


class AnswerInputViewController: UIViewController {
    
    
    var game: Game?
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUIElements()
        // Do any additional setup after loading the view.
    }
    
    func configureUIElements() {
        // self.navigationItem.setHidesBackButton(true, animated:true);
        
        categoryLabel.text = game?.currentQuestion?.category?.title
        priceLabel.text = game?.currentQuestion?.formattedPrice()
        questionTextView.text = game?.currentQuestion?.question
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkAnswer(sender: AnyObject) {
        game?.currentQuestion?.playerAnswer = answerTextView.text
        performSegueWithIdentifier("AnswerVerificationSegue", sender: nil)
    }
   

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AnswerVerificationSegue" {
            if let destinationViewController = segue.destinationViewController as? AnswerVerificationViewController {
                destinationViewController.game = game
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
