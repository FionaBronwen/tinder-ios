//
//  CardsViewController.swift
//  Tinder
//
//  Created by Fiona Thompson on 4/6/17.
//  Copyright © 2017 Fiona Thompson. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        cardImageView.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cardDidPan(_ sender: Any) {
        let translation = (sender as AnyObject).translation(in: view)
        
        if (sender as AnyObject).state == .began {
            cardInitialCenter = cardImageView.center
            print("Gesture began")
            
            
        } else if (sender as AnyObject).state == .changed {
            cardImageView.center = CGPoint(x: cardImageView.center.x + translation.x ,y: cardImageView.center.y)
            if cardImageView.center.x > cardInitialCenter.x {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.cardImageView.transform = self.cardImageView.transform.rotated(by: 0.01)
                })
            } else if cardImageView.center.x < cardInitialCenter.x {
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardImageView.transform = self.cardImageView.transform.rotated(by: -0.01)
                })
            }
            cardImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            print("Gesture is changing")
            
            
            
        } else if (sender as AnyObject).state == .ended {
            if translation.x > 50 {
                UIView.animate(withDuration: 1, animations: { 
                    self.cardImageView.center = CGPoint(x: 1000, y: self.cardImageView.center.y)
                }, completion: { (success: Bool) in
                    if success {
                        self.cardImageView.center = self.cardInitialCenter
                        self.cardImageView.transform = CGAffineTransform.identity
                    }
                })
            } else if translation.x < -50 {
                UIView.animate(withDuration: 1, animations: {
                    self.cardImageView.center = CGPoint(x: -1000, y: self.cardImageView.center.y)
                }, completion: { (success: Bool) in
                    if success {
                        self.cardImageView.center = self.cardInitialCenter
                        self.cardImageView.transform = CGAffineTransform.identity
                    }
                })
            } else {
                self.cardImageView.center = self.cardInitialCenter
                self.cardImageView.transform = CGAffineTransform.identity
            }
            
            print("Gesture ended")
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProfileViewController
        vc.image = cardImageView.image
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
