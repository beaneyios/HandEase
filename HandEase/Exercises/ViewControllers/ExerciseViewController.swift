//
//  ExerciseViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class ExerciseViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var flowController: ExerciseFlowController!
    private var exercise: ExerciseViewModel!
    
    override func viewDidLoad() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.spinner            .startAnimating()
        self.img.alpha          = 0.0
        self.lblTitle.text      = self.exercise.titleLabel
        self.lblBody.text       = self.exercise.body
        
        self.exercise.image { (image) in
            DispatchQueue.main.async {
                self.spinner            .stopAnimating()
                self.img.image          = image
                self.spinner.isHidden   = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.img.alpha      = 1.0
                })
            }
        }
    }
    
    func configure(flowController: ExerciseFlowController, exercise: ExerciseViewModel) {
        self.flowController     = flowController
        self.exercise           = exercise
    }
    
    @IBAction func watchVideo(_ sender: Any) {
        self.flowController.exerciseVideoTapped(exercise: self.exercise)
    }
    
    @IBAction func viewNotes(_ sender: Any) {
        //TODO: Implement notes.
    }
    
    @IBAction func favourite(_ sender: Any) {
       
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.flowController.closeCurrentVC(viewController: self)
    }
}
