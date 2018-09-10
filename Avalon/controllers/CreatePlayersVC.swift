//
//  CreatePlayersVC.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 30/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation
import UIKit

class CreatePlayersVC: UIViewController {
    
    @IBOutlet weak var sview_playerContainer: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let playerCount = GameData.GetGameData().playerCount - 5;
        if(playerCount == 0) { return };
        for _ in 1...playerCount {
            createPlayerTxtField();
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    func createPlayerTxtField() {
        let filteredSubViews = sview_playerContainer.subviews.filter { (uiview) -> Bool in
            return uiview is UITextField
        }
        print(filteredSubViews)
        let lastChild = filteredSubViews.last as! UITextField;
        let scndToLastChild = filteredSubViews[filteredSubViews.count - 2] as! UITextField;
        let frame_lastChild = lastChild.frame;
        let frame_scndToLastChild = scndToLastChild.frame;
        let newY = frame_lastChild.origin.y + (frame_lastChild.origin.y - frame_scndToLastChild.origin.y);
        let newFrame = CGRect(origin: CGPoint(x: frame_lastChild.origin.x, y: newY), size: frame_lastChild.size)
        let newTxtField = UITextField(frame: newFrame);
        newTxtField.font = lastChild.font!;
        newTxtField.textAlignment = .center;
        newTxtField.backgroundColor = UIColor.white;
        newTxtField.placeholder = "player \(filteredSubViews.count + 1)"
        newTxtField.text = newTxtField.placeholder
        sview_playerContainer.addSubview(newTxtField);
    }
    
    @IBAction func btn_next_touchup_inside(_ sender: Any) {
        let filteredSubViews = sview_playerContainer.subviews.filter { (uiview) -> Bool in
            return uiview is UITextField
        }
        let gameData = GameData.GetGameData();
        
        for uiView in filteredSubViews {
            let txtField = uiView as! UITextField;
            if let name = txtField.text {
                gameData.addPlayer(name: name)
            }
        }
    }
}

