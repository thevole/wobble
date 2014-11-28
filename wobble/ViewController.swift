
//
//  ViewController.swift
//  wobble
//
//  Created by Martin Volerich on 11/27/14.
//  Copyright (c) 2014 Bill Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var buttons: [WobbleButton] {
    return self.view.subviews.filter( {el in return el is WobbleButton}) as [WobbleButton]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    buttonsDo(){ button in
      button.delegate = self
    }
  }
  
  @IBAction func stopWobble(button: UIButton) {
    buttonsDo() { button in
      button.stopWobbling = true
    }
  }
  
  private func buttonsDo(action: (WobbleButton) -> ()) {
    for button in buttons {
      action(button)
    }
  }
  
}

extension ViewController: WobbleButtonDelegate {
  func wobbleButtonDidStartToWobble(button: WobbleButton) {
    buttonsDo() {aButton in
      if aButton !== button {
        aButton.wobble()
      }
    }
  }
}

