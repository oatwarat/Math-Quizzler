import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = 0
        restartButton.isHidden = true
        
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let usersAnswer = sender.currentTitle else {
            return
        }
        
        if let currentTitle = sender.currentTitle, !currentTitle.isEmpty {
            if quizBrain.checkAnswer(usersAnswer) {
                sender.backgroundColor = UIColor.green
            } else {
                sender.backgroundColor = UIColor.red
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                sender.backgroundColor = UIColor.clear

                if quizBrain.nextQuestion() {
                    self.questionLabel.text = quizBrain.getQuestionText()
                    self.progressBar.progress = quizBrain.getProgress()
                } else {
                    self.questionLabel.text = "FINISHED!"
                    self.progressBar.progress = 1
                    UIView.animate(withDuration: 0.5) {
                        self.trueButton.alpha = 0
                        self.falseButton.alpha = 0
                        self.restartButton.isHidden = false
                    }
                }

                self.scoreLabel.text = "Score: \(quizBrain.getScore())"
            }
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        // Reset quiz
        quizBrain = QuizBrain()
        self.questionLabel.text = quizBrain.getQuestionText()
        self.progressBar.progress = 0
        self.scoreLabel.text = "Score: 0"
        self.trueButton.isHidden = false
        self.falseButton.isHidden = false
        self.trueButton.alpha = 1
        self.falseButton.alpha = 1
        self.restartButton.isHidden = true
    }
    
    
}

