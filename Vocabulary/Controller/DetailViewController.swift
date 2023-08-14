//
//  DetailViewController.swift
//  Vocabulary
//
//  Created by 陳佩琪 on 2023/8/14.
//

import UIKit
import AVFoundation


class DetailViewController: UIViewController {

    var vocabulary: Vocabulary!
    
    @IBOutlet var wordLabel: UILabel!
    
    @IBOutlet var partOfSpeechLabel: UILabel!
    
    @IBOutlet var chineseLabel: UILabel!
    
    
    @IBOutlet var speedSlider: UISlider!
    
    
    let speaker = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wordLabel.text = vocabulary.word
        partOfSpeechLabel.text = vocabulary.definitions[0].partOfSpeech
        chineseLabel.text = vocabulary.definitions[0].text
        
        utterance = AVSpeechUtterance(string: wordLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
    }
    
    @IBAction func pronouce(_ sender: Any) {
        utterance.rate = speedSlider.value
        speaker.speak(utterance)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
