//
//  ExerciseVideoViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import AVKit

class ExerciseVideoViewController: UIViewController {
    @IBOutlet weak var avContainer: UIView!
    @IBOutlet weak var titleView: UIButton!
    
    private var exercise: ExerciseViewModel!
    private var avController: AVPlayerViewController!
    private var flowController: FlowController!
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureAVPlayer()
        self.loadVideo(exercise: exercise)
        self.hideLoadingLabelOnStart()
    }
    
    func configure(exercise: ExerciseViewModel, flowController: FlowController) {
        self.exercise = exercise
        self.flowController = flowController
    }
    
    private func configureAVPlayer() {
        let vc              = AVPlayerViewController()
        self                .addChild(vc)
        self.avContainer    .addSubview(vc.view)
        self.avContainer    .fixSizeToContainer(subview: vc.view)
        self.avController   = vc
    }
    
    private func loadVideo(exercise: ExerciseViewModel) {
        guard let url               = exercise.videoURL else { return }
        self.avController.player    = AVPlayer(url: url)
        self.avController.player?.play()
    }
    
    private func hideLoadingLabelOnStart() {
        let times = NSValue(time: CMTimeMake(1, 3))
        self.avController.player?.addBoundaryTimeObserver(forTimes: [times], queue: DispatchQueue.main, using: { [weak self] in
            self?.hideLoadingLabel()
        })
    }
    
    private func hideLoadingLabel() {
        UIView.animate(withDuration: 0.3, animations: {
            self.titleView.alpha = 0.0
        })
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.flowController.closeCurrentVC(viewController: self)
    }
}
