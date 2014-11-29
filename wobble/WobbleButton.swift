//
//  WobbleButton.swift
//  wobble
//
//  Created by Martin Volerich on 11/28/14.
//  Copyright (c) 2014 Bill Bear. All rights reserved.
//

import UIKit

@objc protocol WobbleButtonDelegate {
  func wobbleButtonDidStartToWobble(button: WobbleButton)
}

class WobbleButton: UIButton {
  
  private var wobbleLeft = false
  private var wobbling = false
  
  var stopWobbling = false
  var leftWiggle: CGAffineTransform!
  var rightWiggle: CGAffineTransform!
  
  var delegate: WobbleButtonDelegate?
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupButton()
  }
  
  convenience init(image: UIImage) {
    self.init()
    setImage(image, forState: .Normal)
    setupButton()
  }
  
  override init() {
    super.init()
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  func setupButton() {
    let angle = 3.0 * CGFloat(M_PI) / 180.0
    leftWiggle = CGAffineTransformMakeRotation(-angle)
    rightWiggle = CGAffineTransformMakeRotation(angle)
    imageView?.layer.cornerRadius = 10.0
    
    let longPress = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
    self.addGestureRecognizer(longPress)
    
  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    println("Drawing button \(wobbling)")
  }
  
  
  
  func handleLongPress(gesture: UILongPressGestureRecognizer) {
    if gesture.state == .Began {
      wobble()
      delegate?.wobbleButtonDidStartToWobble(self)
    }
  }
  
  func wobble() {
    wobbling = true
    self.setNeedsDisplay()
    doWobble()
  }
  
  private func doWobble() {
    if stopWobbling {
      unwobble()
    } else {
      UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut | .AllowUserInteraction, animations: {
        self.transform = self.wobbleLeft ? self.leftWiggle : self.rightWiggle
        }) { _ in
          self.wobbleLeft = !self.wobbleLeft
          self.doWobble()
      }
    }
  }
  
  private func unwobble() {
    UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseInOut | .AllowUserInteraction | .BeginFromCurrentState, animations: {
      self.transform = CGAffineTransformMakeRotation(0.0)
      }){
        _ in
        self.stopWobbling = false
        self.wobbling = false
    }
  }
  
  
}
