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
    
    var avatar: UIImageView = UIImageView()
    var author: UILabel = UILabel()
    var create_at: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.textLabel?.numberOfLines = 0

        self.contentView.addSubview(avatar)
        self.contentView.addSubview(author)
        self.contentView.addSubview(create_at)
    }
    
    func bind(data: Topic) -> CGFloat {
        self.textLabel?.text = data.title
        self.author.text = data.author?.loginname
        self.create_at.text = data.create_at
        // 计算Cell高度
        
        self.textLabel?.frame = CGRect(x:15, y:10, width: self.contentView.bounds.size.width-30, height:100)
        self.textLabel?.sizeToFit()
        self.layoutIfNeeded()
        // 绑定并计算Cell高度
        return (self.textLabel?.frame.height)!
    }
}
