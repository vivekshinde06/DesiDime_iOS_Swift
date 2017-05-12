//
//  RecentPostTableViewCell.swift
//  DesidimeApp
//
//  Created by PCPL 41 on 5/11/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit

class RecentPostTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnQuote: UIButton!
    @IBOutlet weak var btnLikePoints: UIButton!
    @IBOutlet weak var btnHotDeals: UIButton!
    @IBOutlet weak var btnTime: UIButton!


    @IBOutlet weak var imgUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardSetup()
    }
    
    func cardSetup(){
        
        //  Converted with Swiftify v1.0.6331 - https://objectivec2swift.com/
        cardView.alpha = 1
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 3
        // if you like rounded corners
        cardView.layer.shadowOffset = CGSize(width: CGFloat(-0.2), height: CGFloat(0.2))
        //%%% this shadow will hang slightly down and to the right
        cardView.layer.shadowRadius = 1
        //%%% I prefer thinner, subtler shadows, but you can play with this
        cardView.layer.shadowOpacity = 0.5
        //%%% same thing with this, subtle is better for me
        //%%% This is a little hard to explain, but basically, it lowers the performance required to build shadows.  If you don't use this, it will lag
        var path = UIBezierPath(rect: cardView.bounds)
        cardView.layer.shadowPath = path.cgPath
        backgroundColor = UIColor(red: CGFloat(0.9), green: CGFloat(0.9), blue: CGFloat(0.9), alpha: CGFloat(1))
        //%%% I prefer choosing colors programmatically than on the storyboard
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
