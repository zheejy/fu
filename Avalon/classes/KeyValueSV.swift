//
//  KeyValueSV.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 31/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import UIKit

class KeyValueSV: UIStackView {
    @IBOutlet weak var lbl_key: UILabel!
    @IBOutlet weak var lbl_value: UILabel!
    
    func displayContent(key: String, value: String) {
        lbl_key.text = key;
        lbl_value.text = value;
    }
    
}
