//
//  ViewController.swift
//  EggTimer
//
//  Created by Atin Agnihotri on 10/04/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    /*
     Note to self :
     5 steps to debugging a problem
     1) What did you expect the code to do?
     2) What did your code in actuality?
     3) What does your expectation depend on?
     4) How can we test the things our expectation depend on?
     5) Fix your code to make expectation match reality
     */
    
    var player : AVAudioPlayer!
   
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var titleLabel: UILabel!
    
    let timeDict : [String : Int] = [
        "Soft" : 300,
        "Medium" : 420,
        "Hard" : 720
    ]
    
    var countDown : Int = 0
    var totalTime : Int = 0
    
    var timer : Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        
        setTimer(hardness: hardness)
        
    }
    
    func setTimer(hardness : String) {
        countDownTimer(seconds : timeDict[hardness]!)
    }
    
    func countDownTimer(seconds : Int) {
        countDown = seconds
        totalTime = seconds
        progressBar.progress = 0.0
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.printTimeRemaining), userInfo: nil, repeats: true )
//        timer.fire()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    @objc func printTimeRemaining() {
        if countDown > 0 {
            progressBar.progress = Float(totalTime - countDown) / Float(totalTime)
            print("\(String(countDown)) seconds remaining")
            countDown -= 1
            
        } else {
            titleLabel.text = "Done"
            progressBar.progress = 1.0
            playSound()
            timer?.invalidate()
//            player.play()
        }
    }
    
}

