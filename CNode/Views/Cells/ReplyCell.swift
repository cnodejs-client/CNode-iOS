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

class ReplyCell: UITableViewCell {
    
    var avatar: UIImageView = UIImageView()
    var name: UILabel = UILabel()
    var create_at: UILabel = UILabel()
    var content: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.avatar)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.create_at)
        self.contentView.addSubview(self.content)
        // 回复人头像
        self.avatar.backgroundColor = UIColor.blueColor()
        self.avatar.multipleTouchEnabled = true
        self.avatar.userInteractionEnabled = true
        // 回复人名称
        self.name.textColor = UIColor.grayColor()
        self.name.font = UIFont.systemFontOfSize(14)
        // 回复时间
        self.create_at.textColor = UIColor.grayColor()
        self.create_at.font = UIFont.systemFontOfSize(14)
        // 内容
        self.content.numberOfLines = 0
        self.content.textColor = UIColor.grayColor()
        self.content.font = UIFont.systemFontOfSize(14)
        
        // top -> left -> bottom -> right
        let padding: UIEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
        
        self.avatar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(padding.left)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        self.name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(self.avatar.snp_right).inset(-5)
        }
        self.content.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.name.snp_bottom).inset(-5)
            make.left.equalTo(self.name.snp_left)
            make.right.equalTo(-padding.right)
        }
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
            make.bottom.equalTo(self.content.snp_bottom).inset(-padding.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: Reply) -> CGFloat {
        self.avatar.sd_setImageWithURL(NSURL(string: data.author!.avatar_url!))
        self.name.text = data.author?.loginname
        self.create_at.text = data.create_at
        self.content.text = data.content
        self.setNeedsLayout()
        return 0
    }
    
}
