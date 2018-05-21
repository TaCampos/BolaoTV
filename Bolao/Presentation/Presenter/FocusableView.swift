//
//  FocusableView.swift
//  Bolao
//
//  Created by Tamara Martinelli de Campos on 20/05/18.
//  Copyright © 2018 Tamara Martinelli de Campos. All rights reserved.
//

import UIKit

class FocusableView: UIView {
}

extension FocusableView {

    //Define whether a view can become focused or not
    override var canBecomeFocused:  Bool {
        return true
    }

    //Animate views according to focus engine changes
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let nextView = context.nextFocusedView as? FocusableView {

            nextView.layer.shadowOffset = CGSize(width: 0, height: 10)
            nextView.layer.shadowOpacity = 0.6

            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                nextView.transform = CGAffineTransform(scaleX: 1.2,y: 1.2)
            }, completion: { (result) in

            })
        }

        if let previousView = context.previouslyFocusedView as? FocusableView {

            previousView.layer.shadowOffset = CGSize(width: 0, height: 0)
            previousView.layer.shadowOpacity = 0.0

            previousView.transform = CGAffineTransform(scaleX: 1.0 ,y: 1.0)
        }
    }
}



