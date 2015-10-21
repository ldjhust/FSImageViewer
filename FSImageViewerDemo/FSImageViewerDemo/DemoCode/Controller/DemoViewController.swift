//
//  ViewController.swift
//  FSImageViewerDemo
//
//  Created by ldjhust on 10/21/15.
//  Copyright © 2015 example. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
  
  @IBOutlet weak var cat1: UIImageView!
  @IBOutlet weak var cat2: UIImageView!
  @IBOutlet weak var cat3: UIImageView!
  @IBOutlet weak var dog1: UIImageView!
  
  
  // MARK - view lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tap1 = UITapGestureRecognizer(target: self, action: "tapAImage1")
    let tap2 = UITapGestureRecognizer(target: self, action: "tapAImage2")
    let tap3 = UITapGestureRecognizer(target: self, action: "tapAImage3")
    let tap4 = UITapGestureRecognizer(target: self, action: "tapAImage4")
    
    self.cat1.addGestureRecognizer(tap1)
    self.cat2.addGestureRecognizer(tap2)
    self.cat3.addGestureRecognizer(tap3)
    self.dog1.addGestureRecognizer(tap4)
  }
  
  // MARK - event response
  
  func tapAImage1() {
    FSImageViewer.sharedFSImageViewer.showImageView(self.cat1, atPoint: self.cat1.center)
  }
  
  func tapAImage2() {
    FSImageViewer.sharedFSImageViewer.showImageView(self.cat2, atPoint: self.cat2.center)
  }
  
  func tapAImage3() {
    FSImageViewer.sharedFSImageViewer.showImageView(self.cat3, atPoint: self.cat3.center)
  }
  
  func tapAImage4() {
    FSImageViewer.sharedFSImageViewer.showImageView(self.dog1, atPoint: self.dog1.center)
  }
  
  // MARK - handle memory warning
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

