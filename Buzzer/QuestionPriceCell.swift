//
//  QuestionPriceCell.swift
//  Buzzer
//
//  Created by Asma Harbi on 2016-05-11.
//  Copyright © 2016 Asma Harbi. All rights reserved.
//

import UIKit

class QuestionPriceCell: UICollectionViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    var answered = false {
        
        didSet {
            priceLabel.hidden = answered
        }
    }
    
}
