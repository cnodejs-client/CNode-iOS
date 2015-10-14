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

class MyProfileCell: UITableViewCell {

    var container = UIView()
    var avatar: UIImageView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
    var name: UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .DisclosureIndicator
        // 头像
        self.avatar.backgroundColor = UIColor.blueColor()
        self.avatar.multipleTouchEnabled = true
        self.avatar.userInteractionEnabled = true
        // 名字
        self.name.textColor = UIColor.blackColor()
        self.name.userInteractionEnabled = true
        
        self.contentView.addSubview(self.avatar)
        self.contentView.addSubview(self.name)

        // top -> left -> bottom -> right
        let padding: UIEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 8)
        
        self.avatar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(padding.left)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        self.name.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.avatar.snp_right).inset(-10)
            make.centerY.equalTo(self.avatar)
        }
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
            make.bottom.equalTo(self.avatar.snp_bottom).inset(-padding.bottom)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func bind(data: User?) {
        if (data == nil) {
            self.name.text = "登录/注册"
            self.avatar.sd_setImageWithURL(nil)
        } else {
            self.name.text = data!.loginname
            self.avatar.sd_setImageWithURL(NSURL(string: (data!.avatar_url)!))
        }
    }
}
