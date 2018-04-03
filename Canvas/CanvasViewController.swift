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
      trayOriginalCenter = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    }
  }
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
