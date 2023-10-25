//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var settingLabel: UILabel!
    @IBOutlet private weak var settingSwitch: UISwitch!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        settingLabel.text = nil
    }

    // MARK: - Setup
    func configure(settingName: String) {
        settingLabel.text = settingName
    }

    @IBAction func toggleSettingAction(_ sender: Any) {
        settingLabel.textColor = settingSwitch.isOn ? .black : .red
    }
    
}
