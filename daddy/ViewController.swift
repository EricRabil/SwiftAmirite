//
//  ViewController.swift
//  daddy
//
//  Created by Eric Rabil on 2/19/17.
//  Copyright © 2017 Eric Rabil. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var vibrating = false
    /*
     Basso
     Blow
     Bottle
     Frog
     Funk
     Glass
     Hero
     Morse
     Ping
     Pop
     Purr
     Sosumi
     Submarine
     Tink
 */
    
    let sounds = ["Basso", "Blow", "Bottle", "Frog", "Glass", "Hero", "Morse", "Ping", "Pop", "Purr", "Sosumi", "Submarine", "Tink"]
    
    let messages = ["SEXY DADDY", "oh yes fuck me", "what dat mouth do tho", "wyd girl", "aye",
                    "add me on snapchat: @mrstealurman", "if u wanna smoke i got the weed",
                    "u signle?", "ayeeeeeeeeee", "4 FUCKING TWENTY BLAZE THE SHIT OUT OF IT BITCH", "wyd wyd wyd", "die", "FUCK FUCK FUCK FUCK FUCK FUCK"]

    @IBOutlet weak var label: NSTextField!
    
    @IBOutlet weak var buttonaf: NSButton!
    @IBAction func click1(_ sender: NSButton) {
        vibrating = !vibrating
    }
    
    func doSeizure(){
        if(vibrating){
            //Buzz
            NSHapticFeedbackManager.defaultPerformer().perform(.generic, performanceTime: .now)
            //Random bg
            self.view.layer?.backgroundColor = NSColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0).cgColor
            //Random button bezel
            if #available(OSX 10.12.2, *) {
                buttonaf.bezelColor = NSColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            }
            //Random text color
            label.textColor = NSColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            //Random bg color for label (not sure if it does anything though)
            label.backgroundColor = NSColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            //Random string from messages
            label.stringValue = messages[Int(arc4random_uniform(UInt32(messages.count)))]
            buttonaf.title = messages[Int(arc4random_uniform(UInt32(messages.count)))]
            //Random sound from registry
            NSSound(named: sounds[Int(arc4random_uniform(UInt32(sounds.count)))])?.play()
            //Random brightness
            setBrightnessLevel(level: Float(drand48() / drand48()))
        }
    }
    
    //Function that changes brightness because apple is lazy and wont provide the right API.
    //Gotten from S/O
    func setBrightnessLevel(level: Float) {
        
        var iterator: io_iterator_t = 0
        
        if IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator) == kIOReturnSuccess {
            
            var service: io_object_t = 1
            
            while service != 0 {
                
                service = IOIteratorNext(iterator)
                IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString!, level)
                IOObjectRelease(service)
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(ViewController.doSeizure), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

