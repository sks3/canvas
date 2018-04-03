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
    
    // Do any additional setup after loading the view.
  }
  
  
  @objc func didPan(sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    let velocity = sender.velocity(in: view)
    if sender.state == .began {
      newlyCreatedFace = sender.view as! UIImageView
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
    }
    else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
    }
  }
  
  
  @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    if sender.state == .began {
      var imageView = sender.view as! UIImageView
      newlyCreatedFace = UIImageView(image: imageView.image)
      view.addSubview(newlyCreatedFace)
      newlyCreatedFace.center = imageView.center
      newlyCreatedFace.center.y += trayView.frame.origin.y
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
      
      let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
      newlyCreatedFace.isUserInteractionEnabled = true
      newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
    }
    else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
    }
    
  }
  
  
  
  @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    var velocity = sender.velocity(in: view)
    
    if sender.state == .began {
      trayOriginalCenter = trayView.center
    }
    else if sender.state == .changed {
      trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    }
    else if sender.state == .ended {
      if velocity.y > 0 {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: { () -> Void in
          self.trayView.center = self.trayDown
        }, completion: nil)
      }
      else {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: { () -> Void in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
