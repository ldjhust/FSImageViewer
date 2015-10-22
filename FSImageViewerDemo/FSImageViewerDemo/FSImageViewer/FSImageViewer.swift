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
    self.scrollView.delegate = self
    self.scrollView.minimumZoomScale = 1.0 // 不能缩小
    self.scrollView.maximumZoomScale = 3.0 // 最大放大三倍
    self.scrollView.showsHorizontalScrollIndicator = false // 不显示水平滚动指示器，丑
    self.scrollView.showsVerticalScrollIndicator = false // 垂直滚动指示器也不显示，丑
    
    
    self.contentImageView = UIImageView(image: imageView.image)
    self.contentImageView.bounds.size = imageView.bounds.size
    self.contentImageView.center = atPoint
    
    // 创建一个单击手势，当用户点击图片时返回到没有图片浏览的状态
    let backTapGesture = UITapGestureRecognizer(target: self, action: "tapToBack")
    // 将手势添加到scrollView上
    self.scrollView.addGestureRecognizer(backTapGesture)
    
    // 将contentImageView添加到scrollView上，这样才可以操作
    self.scrollView.addSubview(self.contentImageView)
    // 将scrollView直接添加到keyWindow上成为最上层视图，这样才能被我们看到并进行一系列操作
    self.keyWindow.addSubview(self.scrollView)
    
    // 通过动画来展示scrollView更友好，不会显得太突兀
    self.startAnimate()
  }
  
  // MARK: - event response
  
  /**
  tap手势的响应方法
  
  - parameter : NA
  
  - returns: NA
  */
  func tapToBack() {
    UIView.animateWithDuration(0.3, animations: {
      self.scrollView.alpha = 0.0
      self.contentImageView.frame = self.originalFrame
      }) { (_) in
        // 将scrollView从keyWindow上移除
        self.scrollView.removeFromSuperview()
    }
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

extension FSImageViewer: UIScrollViewDelegate {
  // MARK: - scroll view delegate
  
  // 这个代理方法功能是返回scrollView中的一只subView用来承载缩放结果
  public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    // 需要放大缩小的是图片
    return self.contentImageView
  }
  
  // 这个代理方法在scrollView发生缩放时调用，在这里面我们随时调整图片的位置为我们想要的地方
  public func scrollViewDidZoom(scrollView: UIScrollView) {
    var centerX = self.screenSize.width/2
    var centerY = self.screenSize.height/2
    
    // 时刻让图片出于正确的位置，当图片比屏幕大时，让图片出于scrollView.contentSize的中心，否则
    // 就出于屏幕的中心
    centerX = self.scrollView.contentSize.width > self.screenSize.width ? self.scrollView.contentSize.width/2 : centerX
    centerY = self.scrollView.contentSize.height > self.screenSize.height ? self.scrollView.contentSize.height/2 : centerY
    
    self.contentImageView.center = CGPoint(x: centerX, y: centerY)
  }
}
