//
//  ReposTableViewCell.swift
//  GitHub PeopleFinder
//
//  Created by Наталья Автухович on 29.06.2021.
//

import UIKit

class ReposTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    let reposNamelbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textAlignment = .left
        return lbl
    }()

    let reposDescriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()

    let reposLangLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let reposPrivateLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        return lbl
    }()

    let reposForksLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .left
        return lbl
    }()

override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(reposNamelbl)
    addSubview(reposLangLbl)
    addSubview(reposForksLbl)
    addSubview(reposPrivateLbl)
    addSubview(reposDescriptionLbl)
    
    reposNamelbl.anchor(top: topAnchor, left: leftAnchor, bottom: reposDescriptionLbl.topAnchor, right: nil, paddingTop: 4, paddingLeft: 9, paddingBottom: 2, paddingRight: 0, width: 160, height: 0, enableInsets: false)
    
    reposDescriptionLbl.anchor(top: reposNamelbl.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 9, paddingBottom: 2, paddingRight: 70, width: 120, height: 0, enableInsets: false)
    
    reposLangLbl.anchor(top: topAnchor, left: reposDescriptionLbl.rightAnchor, bottom: reposForksLbl.topAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: -50, paddingBottom: 1, paddingRight: 2, width: 75, height: 0, enableInsets: false)
    reposForksLbl.anchor(top: reposLangLbl.bottomAnchor, left: reposDescriptionLbl.rightAnchor, bottom: reposPrivateLbl.topAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: -50, paddingBottom: 1, paddingRight: 2, width: 75, height: 0, enableInsets: false)
    reposPrivateLbl.anchor(top: reposForksLbl.bottomAnchor, left: reposDescriptionLbl.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: -50, paddingBottom: 0, paddingRight: 2, width: 75, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
