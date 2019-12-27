//
//  ResposTableCell.swift
//  GitHubTask
//
//  Created by Shehata on 12/26/19.
//  Copyright © 2019 shehata. All rights reserved.
//

import UIKit
import Alamofire

class ResposTableCell: UITableViewCell {

    
    var cellObject : ReposElementModel!{
        didSet{
            self.repoNameLabel.text = cellObject.name
            self.photoLoad = cellObject.owner?.avatarURL
            self.userNameLabel.text = cellObject.owner?.login
            self.descriptionTV.text = cellObject.reposModelDescription
        }
    }
    var cellCacheObject : RespocacheModel!{
        didSet{
            self.repoNameLabel.text = cellCacheObject.ReposName
            self.photoLoad = cellCacheObject.avater
            self.userNameLabel.text = cellCacheObject.userName
            self.descriptionTV.text = cellCacheObject.descrip
        }
    }
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var AvaterIV: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    var photoLoad: String? {
        didSet {
            guard let photo = photoLoad else { return }
            
            // download image
            Alamofire.request(photo).response { response in
                if let data = response.data, let image = UIImage(data: data) {
                    self.AvaterIV.image = image
                }
            }
        }
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
