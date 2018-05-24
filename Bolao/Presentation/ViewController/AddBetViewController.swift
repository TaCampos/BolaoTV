//
//  AddBetViewController.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 22/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit
import TvOSScribble

class AddBetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var teamOneScore: UITextField!
    @IBOutlet weak var teamTwoScore: UITextField!

    @IBOutlet weak var labelTest: UILabel!

    
    var autoCompletionTest = ["Rafael", "Danilo", "ZL", "Tamara"]

    var autoCompletionCaracterCount = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = TvOSScribbleGestureRecognizer(target: self, action: #selector(AddBetViewController.gestureDidRecognizer))

        view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func gestureDidRecognizer(recognizer: TvOSScribbleGestureRecognizer) {
        guard recognizer.state == .ended else { return }

        labelTest.text = recognizer.result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var subString = (textField.text!.capitalized as NSString).replacingCharacters(in: range, with: string)
        subString = formatSubstring(subString: subString)

        if subString.count == 0 {
            resetValues()
        } else {
            searchAutocompleteEntriesWithSubstring(substring: subString)
        }

        return true
    }

    func formatSubstring(subString: String) -> String {
        let formatted = String(subString.dropLast(autoCompletionCaracterCount)).lowercased().capitalized
        return formatted
    }

    func resetValues() {
        autoCompletionCaracterCount = 0
        nameTextField.text = ""
    }

    func searchAutocompleteEntriesWithSubstring(substring: String) {
        let userQuery = substring
        let suggestions = getAutocompleteSuggestions(userText: substring)

        if suggestions.count > 0 {
            timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { (timer) in
                let autocompleteResult = self.formatAutocompleteResult(substring: substring, possibleMatches: suggestions)
                self.putColourFormattedTextInTextField(autocompleteResult: autocompleteResult, userQuery: userQuery)
                self.moveCaretToEndOfUserQueryPosition(userQuery: userQuery)
            })
        } else {
            timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { (timer) in
                self.nameTextField.text = substring
            })

            autoCompletionCaracterCount = 0
        }
    }

    func getAutocompleteSuggestions(userText: String) -> [String] {
        var possibleMatches: [String] = []

        for item in autoCompletionTest {
            let myString:NSString! = item as NSString
            let substringRange: NSRange! = myString.range(of: userText)

            if(substringRange.location == 0) {
                possibleMatches.append(item)
            }
        }

        return possibleMatches
    }

    func putColourFormattedTextInTextField(autocompleteResult: String, userQuery: String) {
        let colouredString: NSMutableAttributedString = NSMutableAttributedString(string: userQuery + autocompleteResult)
        let color:UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        colouredString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSRange(location: userQuery.count, length: autocompleteResult.count))
        self.nameTextField.attributedText = colouredString
    }

    func moveCaretToEndOfUserQueryPosition(userQuery: String) {
        if let newPosition = self.nameTextField.position(from: self.nameTextField.beginningOfDocument, offset: userQuery.count) {
            self.nameTextField.selectedTextRange = self.nameTextField.textRange(from: newPosition, to: newPosition)
        }

        let selectedRange: UITextRange? = nameTextField.selectedTextRange
        nameTextField.offset(from: nameTextField.beginningOfDocument, to: (selectedRange?.start)!)
    }

    func formatAutocompleteResult(substring: String, possibleMatches: [String]) -> String {
        var autoCompleteResult = possibleMatches[0]
    autoCompleteResult.removeSubrange(autoCompleteResult.startIndex..<autoCompleteResult.index(autoCompleteResult.startIndex, offsetBy: substring.count))
        autoCompletionCaracterCount = autoCompleteResult.count

        return autoCompleteResult

    }

}
