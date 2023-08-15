//
//  PracticeViewController.swift
//  Vocabulary
//
//  Created by 陳佩琪 on 2023/8/14.
//

import UIKit
import AVFoundation

class PracticeViewController: UIViewController {
    
    
    @IBOutlet var VocabularyLabel: UILabel!
    
    @IBOutlet var partOfSpeechLabel: UILabel!
    
    @IBOutlet var chineseLabel: UILabel!
    
    @IBOutlet var voiceButton: UIButton!
    
    @IBOutlet var voiceSlider: UISlider!
    
    @IBOutlet var inputTextField: UITextField!
    
    @IBOutlet var bottomLineLabel: UILabel!
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var showAnswerButton: UIButton!
    
    
    
    
    let urlStrings = [ "https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/1%E7%B4%9A.json","https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/2%E7%B4%9A.json","https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/3%E7%B4%9A.json","https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/4%E7%B4%9A.json","https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/5%E7%B4%9A.json","https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/6%E7%B4%9A.json"]
    var urlString = "https://raw.githubusercontent.com/AppPeterPan/TaiwanSchoolEnglishVocabulary/main/1%E7%B4%9A.json"
    
    
    var vocabulary = [Vocabulary]()
    
    var letterCount = 0
    var inputLetterCount = 0
    
    var speaker = AVSpeechSynthesizer()
    
    fileprivate func updateUI() {
        // Do any additional setup after loading the view.
        
        let url = URL(string: urlString)
        if let url {
            URLSession.shared.dataTask(with: url) { data, urlRequest, error in
                let decoder = JSONDecoder()
                if let data {
                    do {
                        self.vocabulary = try decoder.decode([Vocabulary].self, from: data)
                        
                        DispatchQueue.main.async {
                            
                            let index = Int.random(in: 0..<self.vocabulary.count)
                            self.VocabularyLabel.text = self.vocabulary[index].word
                            self.partOfSpeechLabel.text = self.vocabulary[index].definitions[0].partOfSpeech
                            self.chineseLabel.text = self.vocabulary[index].definitions[0].text
                            
                            
                            
                            self.letterCount = self.vocabulary[index].letterCount
                            self.setBlankLabel()
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        resetQuestion()

    }
    

    
    
    
    @IBAction func input(_ sender: UITextField) {
        if let text = sender.text {
                inputLetterCount = text.count
            }
        let remainingBottomLine = letterCount - inputLetterCount
        if remainingBottomLine > 0 {
            var blankField = ""
            for _ in 1...remainingBottomLine {
                blankField += " _"
            }
            bottomLineLabel.text = (sender.text ?? "") + blankField
        } else {
            bottomLineLabel.text = (sender.text ?? "")
        }
    }
    
    
    fileprivate func setBlankLabel() {
        var blankField = ""
        for _ in 1...self.letterCount {
            blankField += " _"
        }
        self.bottomLineLabel.text = blankField
    }
    
    
    fileprivate func resetQuestion() {
        inputTextField.text = ""
        bottomLineLabel.isHidden = false
        submitButton.setTitle(ButtonName.submit.nameString, for: .normal)
        showAnswerButton.isHidden = false
        voiceButton.isHidden = true
        voiceSlider.isHidden = true
        inputTextField.becomeFirstResponder()

    }
    
    @IBAction func checkCorrecteness(_ sender: UIButton) {
        
        switch sender.currentTitle  {
            
        case ButtonName.submit.nameString:
            print("correct")
            if bottomLineLabel.text == VocabularyLabel.text {
                bottomLineLabel.isHidden = true
                showAnswerButton.isHidden = true
                voiceButton.isHidden = false
                voiceSlider.isHidden = false
                sender.setTitle(ButtonName.next.nameString, for: .normal)
                inputTextField.resignFirstResponder()
            } else {
                print("incorrect")
                UIView.animate(withDuration: 0.08, delay: 0, options: [.autoreverse, .repeat], animations: {
                    self.bottomLineLabel.transform = CGAffineTransform(translationX: -8, y: 0)
                },completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.bottomLineLabel.layer.removeAllAnimations()
                }
                bottomLineLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
                    self.setBlankLabel()
                }
                inputTextField.text = ""
            }

        case ButtonName.next.nameString:
            print("next question")
            //重新出題
            updateUI()
            resetQuestion()
            setBlankLabel()
            
        case .none:
            print("none")
            
        case .some(_):
            print("none")
        }
        
    }
    
    
    @IBAction func showAnswer(_ sender: Any) {
        inputTextField.resignFirstResponder()
        bottomLineLabel.isHidden = true
        showAnswerButton.isHidden = true
        voiceButton.isHidden = false
        voiceSlider.isHidden = false
        submitButton.setTitle(ButtonName.next.nameString, for: .normal)
        
    }
    
    @IBAction func pronounce(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: VocabularyLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = voiceSlider.value
        speaker.speak(utterance)
    }
    

    @IBAction func selectLevel(_ sender: UISegmentedControl) {
        urlString = urlStrings[sender.selectedSegmentIndex]
        updateUI()
        resetQuestion()
        setBlankLabel()
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
