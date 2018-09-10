//
//  GameDetailsVC.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 02/04/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import UIKit

class GameDetailsVC: UIViewController {
    
    @IBOutlet weak var lbl_playerCount: UILabel!
    @IBOutlet weak var lbl_goodCount: UILabel!
    @IBOutlet weak var lbl_evilCount: UILabel!
    @IBOutlet weak var lbl_gameStatus: UILabel!
    @IBOutlet weak var lbl_questDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gameData = GameData.GetGameData();
        let gameRule = gameData.rule;
        lbl_playerCount.text = String(gameData.playerCount);
        lbl_goodCount.text = String(gameRule.goodCount);
        lbl_evilCount.text = String(gameRule.evilCount);
//        lbl_gameStatus.text = gameData.status.toString()
    }
}
