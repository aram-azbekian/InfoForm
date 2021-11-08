//
//  FormCell.swift
//  InfoForm
//
//  Created by Арам on 01.11.2021.
//

import UIKit

protocol FormCellDelegate {
    func didPressDeleteButton(index: Int)
}

class FormCell: UITableViewCell {
    
    var delegate: FormCellDelegate?
    var index: Int?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        delegate?.didPressDeleteButton(index: index!)
    }
    
}
