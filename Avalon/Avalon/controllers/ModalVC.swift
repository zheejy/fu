//
//  ModalVC.swift
//  Avalon
//
//  Created by Zairah Mae J Ylagan on 30/03/2018.
//  Copyright © 2018 Zairah Mae J Ylagan. All rights reserved.
//

import Foundation
import UIKit


protocol ModalVCDelegate: class {
    func onDismiss() -> Void
}

class ModalVC: UIViewController {
    
    weak var delegate: ModalVCDelegate?
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_message: UILabel!
    @IBOutlet weak var btn_close: UIButton!
    
    var message: String = "Internal Error";
    var titleText: String = "Error";
    var btnText: String = "Close";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_message.text = message;
        lbl_title.text = titleText;
        btn_close.setTitle(btnText, for: .normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lbl_message.text = message;
        lbl_title.text = titleText;
        btn_close.setTitle(btnText, for: .normal)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    @IBAction func btn_close_touchup_inside(_ sender: UIButton) {
        delegate?.onDismiss()
        dismiss(animated: true, completion: nil)
    }
}

