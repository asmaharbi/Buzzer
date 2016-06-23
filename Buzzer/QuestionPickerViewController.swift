 //
//  QuestionPickerViewController.swift
//  Buzzer
//
//  Created by Asma Harbi on 2016-05-09.
//  Copyright © 2016 Asma Harbi. All rights reserved.
//

import UIKit

let numberOfCategories = 4
private let questionsPerCategory = 5

class QuestionPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var QuestionCollectionView: UICollectionView!
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowQuestionBuzzSegue" {
            if let destinationViewController = segue.destinationViewController as? QuestionBuzzViewController {
                destinationViewController.game = game
            }
        }
    }
    

   //MARK:- UICollectionViewDelegate
    
   //MARK:- UICollectionViewDataSource
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedPrice = priceFromIndexPath(indexPath)
        let selectedCategory = categoryFromIndexPath(indexPath)
        
        // Set the selected question on game object
        if let category = game?.categories[selectedCategory] {
            Question.loadQuestion(category, price: selectedPrice, responseHandler: { (error, question) -> () in
                
                if error == nil {
                    
                    self.game?.currentQuestion = question
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.performSegueWithIdentifier("ShowQuestionBuzzSegue", sender: nil)
                    })
                    
                } else {
                    print("Error trying to load question: \(error)")
                }
                
            })
            
        }
    }
    
    private func priceFromIndexPath(indexPath: NSIndexPath) -> Int {
        let row = indexPath.item / numberOfCategories
        let price = (row + 1) * 200
        return price
    }
    
    private func categoryFromIndexPath(indexPath: NSIndexPath) -> Int {
        let column = indexPath.item % numberOfCategories
        return column
    }
    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("QuestionPrice", forIndexPath: indexPath) as? QuestionPriceCell {
//            let price = priceFromIndexPath(indexPath)
//            cell.priceLabel.text = "$\(price)"
//            return cell
//        }
//        
//        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//    }
//    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCategories * questionsPerCategory
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("QuestionPrice", forIndexPath: indexPath) as? QuestionPriceCell {
            let price = priceFromIndexPath(indexPath)
            cell.priceLabel.text = "$\(price)"
            
            let categoryIndex = categoryFromIndexPath(indexPath)
            if categoryIndex < game?.categories.count {
                let category = game?.categories[categoryIndex]
                cell.answered = category?.answeredQuestions[price] != nil
            }
            
            return cell
        }
        
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // This should almost certainly be the correct kind of layout unless it has been changes in the storyboard
        if let layout = QuestionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let interItemSpacing = layout.minimumInteritemSpacing
            let totalSpace: CGFloat = CGFloat(numberOfCategories - 1) * interItemSpacing
            let dimension = floor((QuestionCollectionView.bounds.width - totalSpace) / CGFloat(numberOfCategories))
            return CGSize(width: dimension, height: dimension)
        }
        
        // Return UICollectionViewFloatLayout default size
        return CGSize(width: 50, height: 50)
    }
    


    
}
