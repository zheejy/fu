//
//  CharCollViewCell.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 30/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import UIKit

class CharacterCVCell: UICollectionViewCell {
    
    @IBOutlet var iview_character: UIImageView!
    @IBOutlet var lbl_status: UILabel!
    @IBOutlet var view_overlay: UIView!
    var greenColor = UIColor(red: CGFloat(0), green: CGFloat(127), blue: CGFloat(0), alpha: CGFloat(1))
    var redColor = UIColor(red: CGFloat(206), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(1))
    var id: String?;
    var character: AvalonCharacter?;
    
    private func _updateConent(included: Bool) {
        lbl_status.textColor = included ? greenColor : redColor;
        lbl_status.text = included ? "IncLudEd": "ExcLudEd";
        view_overlay.isHidden = included;
    }
    
    func displayContent(name: String, a_char: AvalonCharacter, included: Bool) {
        self.character = a_char;
        self.id = a_char.id;
        iview_character.image = UIImage(named: name)
        _updateConent(included: included);
    }
    
    func updateStatus(included: Bool) {
        _updateConent(included: included)
    }
}
