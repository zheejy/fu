//
//  AssignCharacterVC.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 30/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation
import UIKit

class AssignCharacterVC: UIViewController, ModalVCDelegate {
    
    @IBOutlet weak var iview_character: UIImageView!
    @IBOutlet weak var lbl_player: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_power: UILabel!
    @IBOutlet weak var btn_done: UIButton!
    @IBOutlet weak var btn_next: UIButton!
    
    var characters = [AvalonCharacter]();
    var characterIndex = 0;
    var playerIndex = 0;
    var currentPlayer: Player?;
    var modalVC: ModalVC?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_done.setTitle("thank you!", for: .disabled)
        modalVC = self.storyboard?.instantiateViewController(withIdentifier: "modalVC") as? ModalVC;
        modalVC?.delegate = self;
        setHiddenState(isHidden: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let gameData = GameData.GetGameData();
        currentPlayer = gameData.players[playerIndex];
        characters = gameData.characters;
        showModal(name: currentPlayer!.name)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    func onDismiss() {
        showDetails();
    }
    
    @IBAction func btn_next_touchup_inside(_ sender: Any) {
    }
    
    @IBAction func btn_done_touchup_inside(_ sender: Any) {
        let gameData = GameData.GetGameData();
        let char = characters[characterIndex];
        gameData.setPlayerCharacter(playerId: currentPlayer!.id, a_charId: char.id)
        characters.remove(at: characterIndex)
        if(playerIndex == gameData.players.count - 1) {
            btn_next.isHidden = false;
            btn_done.isEnabled = false;
        } else {
            playerIndex += 1;
            currentPlayer = gameData.players[playerIndex];
            showModal(name: currentPlayer!.name);
        }
    }
    
    func getRandom(limit: Int) -> Int {
        return Int(arc4random_uniform(UInt32(limit)))
    }
    
    func setHiddenState(isHidden: Bool) {
        self.lbl_player.isHidden = isHidden;
        self.lbl_power.isHidden = isHidden;
        self.lbl_name.isHidden = isHidden;
        self.iview_character.isHidden = isHidden;
        self.btn_done.isHidden = isHidden;
    }
    
    func showDetails() -> Void {
        characterIndex = getRandom(limit: characters.count);
        let selectedChar = characters[characterIndex];
        self.lbl_player.text = "Hi \(currentPlayer?.name ?? "unknown")";
        self.iview_character.image = UIImage(named: selectedChar.imageName);
        self.lbl_name.text = selectedChar.name;
        if let power = selectedChar.power {
            self.lbl_power.text = power;
        } else {
            self.lbl_power.text = "~ no special power ~"
        }
        setHiddenState(isHidden: false)
    }
    
    func showModal(name: String) {
        setHiddenState(isHidden: true)
        modalVC!.message = "Please give the device to \(name). \n If you're \(name) you can look at you're character when ever you're ready.";
        modalVC!.titleText = "Ready?";
        modalVC!.btnText = "Show Me";
        self.present(modalVC!, animated: true, completion: nil)
    }
}
