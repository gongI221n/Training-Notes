//
//  WorkoutTableViewCell.swift
//  Training Notes v2
//
//  Created by Ivan Chaschin on 15.01.2022.
//

import UIKit

class WorkoutCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupWorkout (workout: Workout) {
        
        self.textLabel?.text = workout.name

    }

}
