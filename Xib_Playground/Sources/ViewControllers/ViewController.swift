//
//  ViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RealmSwift
import PKHUD

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var taskTitleLabel: UILabel!
    @IBOutlet private weak var taskNameTextField: UITextField!
    @IBOutlet private weak var taskAssignTextField: UITextField!
    @IBOutlet private weak var addTaskButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    private let realmManager = RealmManager()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskButton.layer.cornerRadius = 12
        configureTableView()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }

    private func showInputError() {
        HUD.flash(.error, delay: 1.0)
        taskTitleLabel.text = "入力不足だよ"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.taskTitleLabel.text = "両方入力してね"
        }
    }

    private func successAction() {
        HUD.flash(.success, delay: 1.0)
        taskTitleLabel.text = "登録完了したよ!"
        taskNameTextField.text = ""
        taskAssignTextField.text = ""
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.taskTitleLabel.text = "どんどん登録しよう!"
        }
    }

    @IBAction func addTaskAction(_ sender: Any) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty,
              let taskAssigned = taskAssignTextField.text, !taskAssigned.isEmpty else {
            showInputError()
            return
        }
        let task = Task()
        task.taskName = taskName
        task.personName = taskAssigned
        realmManager.addTask(task: task)
        successAction()
    }

}

// MARK: - Extensions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmManager.getAllTasks().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let taskData = realmManager.getAllTasks()
        cell.configure(taskData[indexPath.row].taskName, taskData[indexPath.row].personName)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // セルを削除するための処理
        if editingStyle == .delete {
            let taskData = realmManager.getAllTasks()
            let task = taskData[indexPath.row]
            realmManager.deleteTask(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
            HUD.flash(.label("タスクを削除したよ"), delay: 1.0)
        }
    }

    // 高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8
    }

}

// TextFieldの設定
extension ViewController: UITextFieldDelegate {
    // 画面のどこかをタップしたときにキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // Returnキーを押したときにキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
