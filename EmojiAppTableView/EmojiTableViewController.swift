//
//  EmojiTableViewController.swift
//  EmojiAppTableView
//
//  Created by Иван Курганский on 22/10/2023.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavourite: false),
        Emoji(emoji: "🏀", name: "Basketball", description: "The best game in the world", isFavourite: false),
        Emoji(emoji: "🐶", name: "Dog", description: "The best friend", isFavourite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Emoji App"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func addNewEmoji(_ sender: Any) {
        let storyboardVC = UIStoryboard(name: "NewEmojiTableView", bundle: nil).instantiateViewController(withIdentifier: "NewEmojiTableView") as! NewEmojiTableViewController
        let myNavigationController = UINavigationController(rootViewController: storyboardVC)
        storyboardVC.delegate = self
        self.present(myNavigationController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        
        action.backgroundColor = object.isFavourite ? .systemPink : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}

extension EmojiTableViewController: NewEmojiDelegate {
    func didAddEmoji(_ emoji: Emoji) {
        objects.append(emoji)
        let newIndexPath = IndexPath(row: objects.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .fade)
    }
}

