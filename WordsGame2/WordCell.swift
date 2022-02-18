//
//  WordCell.swift
//  WordsGame2
//
//  Created by Влад Мади on 11.02.2022.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
