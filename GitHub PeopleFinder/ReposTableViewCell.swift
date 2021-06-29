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

    let reposNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let reposDescriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let reposLangLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let reposSizeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 18)
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
        addSubview(reposNameLbl)
        addSubview(reposLangLbl)
        addSubview(reposSizeLbl)
        addSubview(reposForksLbl)
        addSubview(reposDescriptionLbl)
            
    
        reposNameLbl.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 15, paddingRight: 5, width: 70, height: 0, enableInsets: false)
        reposLangLbl.anchor(top: reposDescriptionLbl.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: frame.size.width - 30, height: 0, enableInsets: false)
        reposSizeLbl.anchor(top: topAnchor, left: reposLangLbl.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 250, height: 0, enableInsets: false)
        reposForksLbl.anchor(top: topAnchor, left: reposSizeLbl.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 35, height: 35, enableInsets: false)
        reposDescriptionLbl.anchor(top: reposNameLbl.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 70, height: 0, enableInsets: false)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
