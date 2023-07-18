//
//  TaskTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet private weak var taskNameLabel: UILabel!
    @IBOutlet private weak var assignedPersonNameLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = nil
        assignedPersonNameLabel.text = nil
    }

    func configure(_ taskName: String, _ assignedPerson: String) {
        taskNameLabel.text = "タスク: \(taskName)"
        assignedPersonNameLabel.text = "担当: \(assignedPerson)"
    }
    
}
