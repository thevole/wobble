//
//  ConnectionsViewController.swift
//  wobble
//
//  Created by Martin Volerich on 11/29/14.
//  Copyright (c) 2014 Bill Bear. All rights reserved.
//

import UIKit

enum Connection: String {
  case Facebook = "Facebook"
  case Twitter = "Twitter"
  case GooglePlus = "Google"
}

class ConnectionsViewController: UIViewController {

  @IBOutlet weak var scroller: UIScrollView!
  
  var connections = [Connection]()

  override func viewDidLoad() {
    super.viewDidLoad()
    println("Connections: \(connections)")
    buildButtons()
  }
  
  private func buildButtons() {
    var offset = 0.0
    for connection in connections {
      let iconName = "\(connection.rawValue)Icon"
      println(iconName)
      let image = UIImage(named: iconName)
      let button = WobbleButton(image: image!)
      button.frame = CGRect(x: offset, y: 3.0, width: 80.0, height: 72.0)
      offset += 80.0
      button.delegate = self
      scroller.addSubview(button)
    }
    scroller.contentSize = CGSize(width: offset, height: 75.0)
  }
  
  private var connectionButtons: [WobbleButton] {
    return scroller.subviews.filter({sub in return sub is WobbleButton}) as [WobbleButton]
  }
}

extension ConnectionsViewController: WobbleButtonDelegate {
  func wobbleButtonDidStartToWobble(button: WobbleButton) {
    for aButton in connectionButtons {
      if aButton !== button {
        aButton.wobble()
      }
    }
  }
}
