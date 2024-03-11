import Foundation

enum MathOperation: String {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "*"
    case division = "/"
    
    static func random() -> MathOperation {
        let allOperations: [MathOperation] = [.addition, .subtraction, .multiplication, .division]
        let randomIndex = Int(arc4random_uniform(UInt32(allOperations.count)))
        return allOperations[randomIndex]
    }
}

struct QuizBrain {
    var quizQuestion: [Question] = []
    var questionNumber = 0
    var userScore = 0
    
    init() {
        generateQuestions()
    }
    
    mutating func generateQuestions() {
        for _ in 1...10 {
            let num1 = Int.random(in: 1...20)
            let num2 = Int.random(in: 1...20)
            let operation = MathOperation.random()
            let answer: Int
            let isTrueQuestion: Bool
            
            switch operation {
            case .addition:
                answer = num1 + num2
                isTrueQuestion = Bool.random()
            case .subtraction:
                answer = num1 - num2
                isTrueQuestion = Bool.random()
            case .multiplication:
                answer = num1 * num2
                isTrueQuestion = Bool.random()
            case .division:
                // Ensure that the division is valid and results in an integer answer
                if num2 != 0 && num1 % num2 == 0 {
                    answer = num1 / num2
                } else {
                    // If division is not valid, change the operation to addition
                    answer = num1 + num2
                }
                isTrueQuestion = Bool.random()
            }
            
            let questionText: String
            if isTrueQuestion {
                questionText = "\(num1) \(operation.rawValue) \(num2) = \(answer)"
            } else {
                // If the random is False
                let falseAnswer = answer + Int.random(in: 1...10)
                questionText = "\(num1) \(operation.rawValue) \(num2) = \(falseAnswer)"
            }
            
            let question = Question(text: questionText, answer: isTrueQuestion ? "True" : "False")
            quizQuestion.append(question)
        }
    }
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quizQuestion[questionNumber].answer {
            userScore += 1
            return true
        } else {
            return false
        }
    }
    
    func getScore() -> Int {
        return userScore
    }
    
    func getQuestionText() -> String {
        return quizQuestion[questionNumber].text
    }
    
    func getProgress() -> Float {
        let progress = Float(questionNumber) / Float(quizQuestion.count)
        return progress
    }
    
    mutating func nextQuestion() -> Bool {
        if questionNumber < quizQuestion.count - 1 {
            self.questionNumber += 1
            return true
        } else {
            return false
        }
    }
    
    
}
