//
//  MainViewController.swift
//  wobble
//
//  Created by Martin Volerich on 11/29/14.
//  Copyright (c) 2014 Bill Bear. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.title = "Two"
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "connections" {
      let connections: [Connection] = [.Facebook, .Twitter, .GooglePlus, .Twitter, .Twitter, .Facebook]
      let connectionsVC = segue.destinationViewController as ConnectionsViewController
      connectionsVC.connections = connections
    }
  }


}
