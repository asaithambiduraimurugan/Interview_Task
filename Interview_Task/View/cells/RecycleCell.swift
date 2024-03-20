//
//  RecycleCell.swift
//  Interview_Task
//
//  Created by Asaithambi on 8/30/23.
//

import UIKit

class RecycleCell: UITableViewCell {
    @IBOutlet weak var cell_IMG: UIImageView!
    
    @IBOutlet weak var name_Lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
