//
//  ReposTableViewCell.swift
//  GitHub PeopleFinder
//
//  Created by Наталья Автухович on 29.06.2021.
//

import UIKit

class ReposTableViewCell: UITableViewCell {

    @IBOutlet var reposPrivateLbl: UILabel!

    @IBOutlet var reposDescriptionLbl: UILabel!
    @IBOutlet var reposNamelbl: UILabel!
    @IBOutlet var reposForksLbl: UILabel!
    @IBOutlet var reposLangLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    let reposNameLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.boldSystemFont(ofSize: 24)
//        lbl.textAlignment = .left
//        return lbl
//    }()
//
//    let reposDescriptionLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 24)
//        lbl.textAlignment = .left
//        return lbl
//    }()
//
//    let reposLangLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 18)
//        lbl.textAlignment = .left
//        return lbl
//    }()
//    let reposPrivateLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 18)
//        lbl.textAlignment = .left
//        return lbl
//    }()
//
//    let reposSizeLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 18)
//        lbl.textAlignment = .left
//        return lbl
//    }()
//
//    let reposForksLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.textColor = .black
//        lbl.font = UIFont.systemFont(ofSize: 18)
//        lbl.textAlignment = .left
//        return lbl
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
