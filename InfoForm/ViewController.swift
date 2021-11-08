//
//  ViewController.swift
//  InfoForm
//
//  Created by Арам on 29.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButtonView: UIButton!
    
    var childrenArray = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FormCell", bundle: nil), forCellReuseIdentifier: "FormCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    @IBAction func cleanButtonPressed(_ sender: UIButton) {
        let dropDataAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { action in
            self.saveData()
            for _ in 0..<self.childrenArray.count {
                self.deleteCell(idx: 0)
            }
            self.addButtonView.isHidden = false
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            // do nothing
        }
        
        let alert = UIAlertController(title: "Удалить все введенные данные?", message: "", preferredStyle: .actionSheet)
        alert.addAction(dropDataAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addChildButtonPressed(_ sender: UIButton) {
        saveData()
        self.childrenArray.append(Child(name: "", age: ""))
        if self.childrenArray.count == 5 {
            addButtonView.isHidden = true
        }
        tableView.reloadData()
    }
    
    func deleteCell(idx: Int) {
        childrenArray.remove(at: idx)
        addButtonView.isHidden = false
        tableView.reloadData()
    }
    
    func saveData() {
        if !childrenArray.isEmpty {
            for i in 0..<childrenArray.count {
                let cell = tableView.cellForRow(at: IndexPath(item: i, section: 0)) as! FormCell
                childrenArray[i].age = cell.ageTextField.text ?? ""
                childrenArray[i].name = cell.nameTextField.text ?? ""
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormCell", for: indexPath) as! FormCell
        let row = indexPath.row
        cell.delegate = self
        cell.index = row
        
        cell.nameTextField.text = childrenArray[row].name
        cell.ageTextField.text = childrenArray[row].age
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension ViewController: FormCellDelegate {
    func didPressDeleteButton(index: Int) {
        saveData()
        deleteCell(idx: index)
    }
}
