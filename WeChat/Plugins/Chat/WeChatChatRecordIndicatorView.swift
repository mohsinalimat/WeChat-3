//
//  WeChatChatRecordIndicatorView.swift
//  WeChat
//
//  Created by Smile on 16/3/29.
//  Copyright © 2016年 smile.love.tao@gmail.com. All rights reserved.
//

import UIKit

let talkMessage:String = "手指上滑,取消发送"
let talkCancelMessage:String = "松开手指,取消发送"
let talkButtonDefaultMessage:String = "按住 说话"
let talkButtonHightedMessage:String = "松开结束"
let shortTalkMessage:String = "说话时间太短"

//时间太短view
class WeChatChatRecordShortView:WeChatChatRecordIndicatorNormalView {
    
    init(frame: CGRect) {
        super.init(frame: frame, text: shortTalkMessage, image: UIImage(named: "chatTooShort")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//录音取消view
class WeChatChatRecordIndicatorCancelView: WeChatChatRecordIndicatorNormalView {
    
    init(frame: CGRect) {
        super.init(frame: frame, text: talkCancelMessage,textColor:UIColor.whiteColor(),image: UIImage(named: "chatCancel")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WeChatChatRecordIndicatorView: WeChatChatRecordIndicatorNormalView {
    
    let images:[UIImage]
    
    init(frame: CGRect) {
        self.images = [UIImage(named: "record_animate_01")!,
                  UIImage(named: "record_animate_02")!,
                  UIImage(named: "record_animate_03")!,
                  UIImage(named: "record_animate_04")!,
                  UIImage(named: "record_animate_05")!,
                  UIImage(named: "record_animate_06")!,
                  UIImage(named: "record_animate_07")!,
                  UIImage(named: "record_animate_08")!,
                  UIImage(named: "record_animate_09")!]
        super.init(frame: frame,text:talkMessage,image: images[0])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARKS: 显示文本
    func showText(text: String, textColor: UIColor = UIColor.blackColor()) {
        textLabel.textColor = textColor
        textLabel.text = text
    }
    
    func updateLevelMetra(levelMetra: Float) {
        if levelMetra > -20 {
            showMetraLevel(8)
        } else if levelMetra > -25 {
            showMetraLevel(7)
        }else if levelMetra > -30 {
            showMetraLevel(6)
        } else if levelMetra > -35 {
            showMetraLevel(5)
        } else if levelMetra > -40 {
            showMetraLevel(4)
        } else if levelMetra > -45 {
            showMetraLevel(3)
        } else if levelMetra > -50 {
            showMetraLevel(2)
        } else if levelMetra > -55 {
            showMetraLevel(1)
        } else if levelMetra > -60 {
            showMetraLevel(0)
        }
    }
    
    
    func showMetraLevel(level: Int) {
        if level > images.count {
            return
        }
        performSelectorOnMainThread("showIndicatorImage:", withObject: NSNumber(integer: level), waitUntilDone: false)
    }
    
    func showIndicatorImage(level: NSNumber) {
        imageView.image = images[level.integerValue]
    }
    
}

class WeChatChatRecordIndicatorNormalView: UIView {
    let imageView: UIImageView
    let textLabel: UILabel
    
    init(frame: CGRect,text:String,textColor:UIColor = UIColor.whiteColor(),image:UIImage) {
        textLabel = UILabel()
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.systemFontOfSize(13.0)
        textLabel.text = text
        textLabel.textColor = textColor

        imageView = UIImageView(frame: CGRectZero)
        imageView.image = image
        
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        self.alpha = 0.6
        
        // 增加毛玻璃效果
        let visualView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visualView.frame = self.bounds
        visualView.layer.cornerRadius = 10.0
        self.layer.cornerRadius = 10.0
        visualView.layer.masksToBounds = true
        
        addSubview(visualView)
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: -15))
        
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1, constant: 10))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
