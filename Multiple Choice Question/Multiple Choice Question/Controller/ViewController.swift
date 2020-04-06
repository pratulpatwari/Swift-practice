//
//  ViewController.swift
//  Multiple Choice Question
//
//  Created by pratul patwari on 6/2/18.
//  Copyright © 2018 pratul patwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    // outlet for Buttons
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateQuestion()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func answerPressed(_ sender: UIButton) {
        
//        if sender.tag == 1{
//            print("option a")
//        } else if sender.tag == 2 {
//            print("option b")
//        } else if sender.tag == 3{
//            print ("option c")
//        } else {
//            print("option d")
//        }
        if sender.tag == selectedAnswer {
            print("correct answer pressed")
            score += 1
        } else {
            print("wrong answer")
        }
        questionNumber += 1
        updateQuestion()
    }
    
    func updateQuestion(){
        
        if questionNumber <= (allQuestions.list.count-1){
            flagView.image = UIImage(named: (allQuestions.list[questionNumber].questionImage))
            questionLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: UIControlState.normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: UIControlState.normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: UIControlState.normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: UIControlState.normal)
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
        } else{
            print("Thanks for answering all the questions")
            restartQuiz()
        }
        updateUI()
        
    }
    
    func updateUI(){
        scoreLabel.text = "Score: \(score)"
        questionCounter.text = "\(questionNumber + 1)/ \(allQuestions.list.count)"
        progressView.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
    }
    
    func restartQuiz(){
        score = 0
        questionNumber = 0
        updateQuestion()
    }
    

}

