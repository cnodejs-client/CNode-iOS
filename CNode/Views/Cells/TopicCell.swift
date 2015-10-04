/**
* Copyright (C) 2015 JianyingLi
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit
import SnapKit

class TopicCell: UITableViewCell {
    
    var title: UILabel = UILabel()
    var avatar: UIImageView = UIImageView()
    var author: UILabel = UILabel()
    var create_at: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.avatar)
        self.contentView.addSubview(self.author)
        self.contentView.addSubview(self.create_at)
        // temp code
        self.title.backgroundColor = UIColor.grayColor()
    }
    
    func bind(data: Topic) -> CGFloat {
        self.title.frame = CGRectMake(0, 0, 200, 50)
        
        self.title.text = data.title//! + data.title! + data.title!
        self.author.text = data.author?.loginname
        self.create_at.text = data.create_at
        // 计算Cell高度
        self.title.numberOfLines = 0
        self.title.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
//        self.title.sizeToFit()
//        self.title.layoutIfNeeded()
//        self.layoutIfNeeded()

        // 绑定并计算Cell高度
        return (self.title.frame.height)
    }
}
