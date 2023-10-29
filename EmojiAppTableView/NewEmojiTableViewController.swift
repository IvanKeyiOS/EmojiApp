//
//  NewEmojiTableViewController.swift
//  EmojiAppTableView
//
//  Created by Иван Курганский on 22/10/2023.
//

import UIKit

protocol NewEmojiDelegate: AnyObject {
    func didAddEmoji(_ emoji: Emoji)
}

class NewEmojiTableViewController: UITableViewController {
    
    weak var delegate: NewEmojiDelegate?
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveButton()
    }
    
    private func updateSaveButton() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }

    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    @IBAction private func saveButtonAction(_ sender: Any) {
        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
        delegate?.didAddEmoji(self.emoji)
        dismiss(animated: true)
    }
        
    @IBAction func cancelButtonAction() {
        dismiss(animated: true)
    }
}
