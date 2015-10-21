//
//  FSImageViewer.swift
//  FSImageViewerDemo
//
//  Created by ldjhust on 10/21/15.
//  Copyright © 2015 example. All rights reserved.
//

import UIKit

// 通过单例来提供服务
private let _sharedFSImageViewer = FSImageViewer()

public class FSImageViewer: UIView {
  
  // 默认可供操作的实例
  public class var sharedFSImageViewer: FSImageViewer {
    return _sharedFSImageViewer
  }
  
  private let keyWindow: UIWindow = UIApplication.sharedApplication().keyWindow!
  private let screenSize: CGSize = UIScreen.mainScreen().bounds.size
  
  private var originalFrame: CGRect! // 被查看图片的初始frame，保存下来用来返回的时候用
  private var scrollView: UIScrollView! // scrollView用来承载图片的放大、缩小、平移等各种手势
  private var contentImageView: UIImageView! // 被查看图片的拷贝，用来在scrollView上显示
  
  // MARK: - API
  
  /**
  这个方法用来完成所有必要的初始化
  
  - parameter imageView:    需要被查看的图片视图(注意请传入图片所在的ImageView)
  - parameter atPoint: 这个点会被用来作为图片在屏幕上的中心点(center)，建议传入被查看图片的在屏幕上的中心坐标
  
  - returns: NA
  */
  public func showImageView(imageView: UIImageView, atPoint: CGPoint) {
    // 记录下图片的原始frame，用来在最后返回时能够直接使用，让图片返回到最初始的状态，这样可以让浏览在视觉上更连贯
    self.originalFrame = imageView.frame
    
    self.scrollView = UIScrollView(frame: CGRect(x: 0,
                                                 y: 0,
                                             width: self.screenSize.width,
                                            height: self.screenSize.height))
    // 设置scrollView的背景色被黑色，因为通常图片浏览器的背景色都是黑色
    self.scrollView.backgroundColor = UIColor.blackColor()
    // 设置scrollView的不透明度为0，即100%透明，用于展示背景逐渐出现的效果
    self.scrollView.alpha = 0.0
    
    
    self.contentImageView = UIImageView(image: imageView.image)
    self.contentImageView.bounds.size = imageView.bounds.size
    self.contentImageView.center = atPoint
    
    // 将contentImageView添加到scrollView上，这样才可以操作
    self.scrollView.addSubview(self.contentImageView)
    // 将scrollView直接添加到keyWindow上成为最上层视图，这样才能被我们看到并进行一系列操作
    self.keyWindow.addSubview(self.scrollView)
    
    // 通过动画来展示scrollView更友好，不会显得太突兀
    self.startAnimate()
  }
  
  // MARK: - private methods
  
  /**
  一个动画，将scrollView通过渐现的方式呈现出来
  
  - parameter : NA
  
  - returns: NA
  */
  private func startAnimate() {
    UIView.animateWithDuration(0.3) {
      self.scrollView.alpha = 1.0 // scrollView由完全透明变为完全不透明
      self.contentImageView.bounds.size.width = self.screenSize.width
      // 等比例缩放，计算出原始的height、width比例，用以推算出所需的高度
      let whRatio = self.originalFrame.height/self.originalFrame.width
      self.contentImageView.bounds.size.height = whRatio * self.screenSize.width
      // 将图片移到屏幕的中心来
      self.contentImageView.center = CGPoint(x: self.screenSize.width/2,
                                             y: self.screenSize.height/2)
    }
  }
}
