//
//  CanvasViewController.swift
//  Canvas
//
//  Created by somi on 4/2/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
  
  @IBOutlet var trayView: UIView!
  @IBOutlet var arrowView: UIImageView!
  @IBOutlet var canvasView: UIView!
  
  var trayOriginalCenter: CGPoint!
  var trayDownOffset: CGFloat!
  var trayUp: CGPoint!
  var trayDown: CGPoint!
  var newlyCreatedFace: UIImageView!
  var newlyCreatedFaceOriginalCenter: CGPoint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    trayDownOffset = 240
    trayUp = trayView.center
    trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapTray(sender:)))
    tapGestureRecognizer.numberOfTapsRequired = 2
    trayView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc func didDoubleTapTray(sender: UITapGestureRecognizer) {
    for view in canvasView.subviews {
      if view.restorationIdentifier == "newFace" {
        view.removeFromSuperview()
      }
    }
  }
  
  @objc func didDoubleTap(sender: UITapGestureRecognizer) {
    newlyCreatedFace.removeFromSuperview()
  }
  
  @objc func didPan(sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    let velocity = sender.velocity(in: view)
    if sender.state == .began {
      newlyCreatedFace = sender.view as! UIImageView
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
      
      UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
        self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      }, completion: nil)
    }
    else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
      UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
        self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      }, completion: nil)
    }
    else if sender.state == .ended {
      UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
        self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      }, completion: nil)
    }
  }
  
  @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    if sender.state == .began {
      var imageView = sender.view as! UIImageView
      newlyCreatedFace = UIImageView(image: imageView.image)
      newlyCreatedFace.restorationIdentifier = "newFace"
      view.addSubview(newlyCreatedFace)
      newlyCreatedFace.center = imageView.center
      newlyCreatedFace.center.y += trayView.frame.origin.y
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
      
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(sender:)))
      tapGestureRecognizer.numberOfTapsRequired = 2
      newlyCreatedFace.addGestureRecognizer(tapGestureRecognizer)
      
      let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
      newlyCreatedFace.isUserInteractionEnabled = true
      newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
      
      UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
        self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      }, completion: nil)
    }
    else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
      UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
        self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      }, completion: nil)
    }
    else if sender.state == .ended {
      UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
        self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      }, completion: nil)
    }
  }
  
  @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    var velocity = sender.velocity(in: view)
    
    if sender.state == .began {
      trayOriginalCenter = trayView.center
    }
    else if sender.state == .changed {
      if trayView.center.y < trayUp.y {
        trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y/3)
      }
      else {
        trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
      }
    }
    else if sender.state == .ended {
      if velocity.y > 0 {
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: [], animations: { () -> Void in
          self.trayView.center = self.trayDown
        }, completion: nil)
      }
      else {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: [], animations: { () -> Void in
          self.trayView.center = self.trayUp
        }, completion: nil)
      }
      trayOriginalCenter = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
