//
//  MainViewController.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 29/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var txtField_noOfPlayers: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func btn_start_touchup_inside(_ sender: UIButton) {
        GameData.GetGameData(playerCount: Int(txtField_noOfPlayers.text!)!);
    }
    
}
