//
//  AdminCell.swift
//  AIPL ABRO
//
//  Created by call soft on 24/04/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import UIKit

class AdminCell: UITableViewCell {
    
    //MARK:- Variable
    //MARK:-
    let mainView = DropView()
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        //contentView.backgroundColor = CommonClass.sharedInstance.commonAppGrayColor
        
        addSubview(mainView)
        configureComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Configure UIComponent
    //MARK:-
    
    func configureComponent(){
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.scrollAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        mainView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        mainView.DropBtn.setImage(#imageLiteral(resourceName: "right_black"), for: .normal)
        mainView.MainView.layer.cornerRadius = 0
        mainView.MainView.backgroundColor = CommonClass.sharedInstance.commonwhiteColor
        mainView.MainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(CommonClass.sharedInstance.commonHeight))
        
        
    }
}
