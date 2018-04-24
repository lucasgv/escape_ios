//
//  ProfileViewController.swift
//  solution
//
//  Created by Lucas Goes Valle on 23/04/2018.
//  Copyright © 2018 Lucas Goes Valle. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDetails.layer.cornerRadius = 8
        self.viewDetails.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = self.scrollView.panGestureRecognizer.translation(in: self.scrollView.superview!)
        if translation.y > 100 {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
