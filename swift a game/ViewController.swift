//
//  ViewController.swift
//  swift a game
//
//  Created by 张宏毅 on 15/2/9.
//  Copyright (c) 2015年 zhy. All rights reserved.
//
import QuartzCore
import AVFoundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel:UILabel!
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet weak var roundLabel:UILabel!
    var targetValue:Int = 0//定义targetValue
    var currentValue:Int = 50
    var score = 0
    var round = 0
    func startNewRound(){
        round = round + 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)}
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }//括号一定要有首有尾
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        //滑块样式
        let thumblmageNormal = UIImage(named: "SlideThumb-Normal")
        slider.setThumbImage(thumblmageNormal,forState: .Normal)
        let thumblmageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumblmageHighlighted, forState:.Highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named:"SlidertrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImageWithCapInsets(insets)
        slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImageWithCapInsets(insets)
        slider.setMaximumTrackImage(trackRightImage, forState: .Normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert(){//弹出框的内容
//        var different: Int
//        if(currentValue > targetValue){
//            different = currentValue - targetValue
//        }else if currentValue < targetValue{
//            different = targetValue - currentValue
//        }else{
//            different = 0
//        }1.这个是最基本的差值计算方法
        let difference = abs(targetValue - currentValue)//这个是最简单的差值计算方法，abs表示取绝对值，targetValue和currentValue都是Int，所以不用再声明了。
        var points = 100 - difference
        score += points
        var title: String
        if difference == 0{
            title = "完美，你可以去买彩票了！！！"
            points += 100
        }else if difference < 5{
            title = "还差一点哦"
            if difference == 1{
                points += 50}
        }else if difference < 10{
            title = "继续加油哦！"
            points += 10
        }else{
            title = "差远了"
            points += 1
        }
        let message = "大侠，你的得分是： \(points)"
//        let message = "滑动条的数值是： \(currentValue)"
//                    + "\n目标数值是： \(targetValue)"
//                    + "\n差值是: \(difference)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "爱卿辛苦了", style: .Default, handler: {action in
            self.startNewRound()
            self.updateLabels()//增加个闭包，目的是为了使滑块可以在关闭对话框时回到初始位置（self表示闭包）
        })
        alert.addAction(action)
        presentViewController(alert,animated:true,completion:nil)
       // var audioPlayer:AVAudioPlayer!
        
//        startNewRound()
//        updateLabels()
    }
    @IBAction func sliderMoved(slider:UISlider){//这个是本地变量  用完就销毁了
        //println("滑动条现在的数值是： \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    @IBAction func startOver(){
        startNewGame()
        updateLabels()
        //增加淡入淡出效果,这个很好!
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut); view.layer.addAnimation(transition, forKey: nil)
    }
}
