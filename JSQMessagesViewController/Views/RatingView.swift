//
//  RatingView.swift
//  JSQMessages
//
//  Created by Danilo Aliberti on 28/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//
import UIKit
import AfroLayout

@objc public protocol RatingViewDelegate: class {
    func selectedRating (selectedRating rating: NSInteger)
}

public class RatingView: UIView {
    let numberOfButtons: NSInteger
    var buttons: [UIButton]
    let maxWidth: CGFloat
    weak var delegate: RatingViewDelegate?
    public weak var message: JSQMessage?
    init(numberOfButtons: NSInteger, maxWidth: CGFloat, initialRating: NSInteger) {
        self.numberOfButtons = numberOfButtons
        self.maxWidth = maxWidth
        self.buttons = []
        super.init(frame: CGRectZero)
        self.buttons = self.createButtons(self.numberOfButtons)
        
        self.setupUiFromButtons(withButtons: self.buttons, maxWidth: self.maxWidth)
        self.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.3)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRating(rating: NSInteger) {
        
        if let delegate = self.delegate {
            delegate.selectedRating(selectedRating: rating)
        }
    }
    
    func createButtons(numberOfButtons: NSInteger) -> [UIButton] {
        var buttons: [UIButton] = []
        var quantity = numberOfButtons
        while quantity > 0 {
            buttons.append(self.createButton())
            quantity -= 1
        }
        return buttons
    }
    
    func createButton() -> UIButton {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.setImage(UIImage.init(named: "rating-star-unselected"), forState: UIControlState.Normal)
        button.setImage(UIImage.init(named: "rating-star-selected"), forState: UIControlState.Selected)
        button.addTarget(self, action: #selector(RatingView.buttonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    func buttonPressed(button: UIButton) {
        let index = self.buttons.indexOf(button)
        if let index = index {
            self.setRating(index)
            self.selectedRating(selectedRating: index+1)
        }
    }
    
    func setupUiFromButtons(withButtons buttons:[UIButton], maxWidth:CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let starDimension: CGFloat = 25
        
        let height: CGFloat = maxWidth / CGFloat (buttons.count)
//        self.addDimensions(width: maxWidth, height: height)
        self.bounds = CGRectMake(0, 0, maxWidth + 5, height);
        
        for button in buttons {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.3)
            self.addSubview(button)
            button.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            button.addDimensions(width: starDimension, height: starDimension)
            button.addCustomConstraints(inView: self, selfAttributes: [.Top, .Bottom])
            
            button.addCustomConstraints(inView: self,
                                            toViews: self.buttons,
                                            selfAttributes: [.Width, .Height],
                                            relations: [.Equal, .Equal],
                                            otherViewAttributes: [.Width, .Height] )
            
        }
        
        self.stackHorizontallViews(self.buttons)
        
        
        
        
        self.layoutIfNeeded()
        
        /*
         -(void)setupUiFromButtons:(NSArray *)buttons maxWidth:(CGFloat)maxWidth {
         CGFloat height = maxWidth / buttons.count;
         self.bounds = CGRectMake(0, 0, maxWidth + 5, height);
         
         // Constraints: H:[Button][Button]...buttons.count
         //              V:|[Button]|
         UIButton *prevButton = nil;
         for(UIButton *button in buttons) {
         button.translatesAutoresizingMaskIntoConstraints = NO;
         [self addSubview:button];
         
         if(prevButton) {
         // contrain to right of prev button
         NSDictionary *views = NSDictionaryOfVariableBindings(prevButton, button);
         [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[prevButton][button(==prevButton)]" options:0 metrics:nil views:views]];
         [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(==prevButton)]|" options:0 metrics:nil views:views]];
         } else {
         // constrain first button to left of view
         NSDictionary *views = NSDictionaryOfVariableBindings(button);
         [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]" options:0 metrics:nil views:views]];
         [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|" options:0 metrics:nil views:views]];
         
         NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
         NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
         [self addConstraints:@[width, height]];
         }
         
         prevButton = button;
         }
         
         [self layoutIfNeeded];
         }
         */
    }
}

@objc public extension RatingView: RatingViewDelegate {
    public func selectedRating(selectedRating rating: NSInteger) {
        
    }
}