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

class UserProfileHeader: UIView {

    var cover: UIView = UIView()
    var avatar: UIImageView = UIImageView()
    var name: UILabel = UILabel()
    var profile: UILabel = UILabel()
    var edit: UIButton = UIButton(frame: CGRectMake(0, 0, 0, 0), style: .Default)
    var location: UILabel = UILabel()
    var homepage: UILabel = UILabel()
    var pointNumber: UILabel = UILabel()
    var topicCount: UILabel = UILabel()
    var topicType: UISegmentedControl = UISegmentedControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRectMake(0, 0, 0, 0)
        self.backgroundColor = UIColor.whiteColor()
        // 资料背景
        self.cover.backgroundColor = Theme.color.navigationBarBackground()
        // 头像
        self.avatar.backgroundColor = UIColor.blueColor()
        self.avatar.multipleTouchEnabled = true
        self.avatar.userInteractionEnabled = true
        self.avatar.layer.masksToBounds = true
        self.avatar.layer.cornerRadius = 5
        self.avatar.layer.borderWidth = 3
        self.avatar.layer.borderColor = UIColor.whiteColor().CGColor
        // 名字
        self.name.text = "名字"
        self.name.textColor = Theme.color.title()
        self.name.userInteractionEnabled = true
        self.name.font = UIFont.boldSystemFontOfSize(16)
        // 个人说明
        self.profile.text = "个人简介"
        self.profile.textColor = Theme.color.content()
        self.profile.font = UIFont.systemFontOfSize(14)
        // 编辑个人资料
        self.edit.frame = CGRectMake(0, 0, 0, 0)
        self.edit.setTitle("编辑个人资料", forState: UIControlState.Normal)
        self.edit.setTitleColor(Theme.color.content(), forState: UIControlState.Normal)
        self.edit.titleLabel?.font = UIFont.boldSystemFontOfSize(12)
        self.edit.layer.borderColor = Theme.color.content().CGColor
        // 所在城市
        self.location.text = "深圳"
        self.location.textColor = Theme.color.content()
        self.location.font = UIFont.systemFontOfSize(14)
        // 个人主页
        self.homepage.text = "http://jianying.li"
        self.homepage.textColor = Theme.color.content()
        self.homepage.font = UIFont.systemFontOfSize(14)
        // 积分
        self.pointNumber.text = "10"
        // 主题数
        self.topicCount.text = "10"
        // 主题分类
//        self.topicType.tintColor = Theme.color.navigationBarBackground()
        self.topicType.insertSegmentWithTitle("话题", atIndex: 0, animated: true)
        self.topicType.insertSegmentWithTitle("参与", atIndex: 1, animated: true)
        self.topicType.selectedSegmentIndex = 0
        
        self.addSubview(self.cover)
        self.addSubview(self.avatar)
        self.addSubview(self.name)
        self.addSubview(self.profile)
        self.addSubview(self.edit)
        self.addSubview(self.location)
        self.addSubview(self.homepage)
        self.addSubview(self.pointNumber)
        self.addSubview(self.topicCount)
        self.addSubview(self.topicType)
        
        let separator: UIView = UIView()
        self.addSubview(separator)
        separator.backgroundColor = Theme.color.separatorColor()
        separator.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }

        // top -> left -> bottom -> right
        let padding: UIEdgeInsets = UIEdgeInsetsMake(60, 10, 8, 10)
        self.cover.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(80)
        }
        self.avatar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(padding.left)
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        self.name.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(padding.left)
            make.top.equalTo(self.avatar.snp_bottom).inset(-5)
        }
        self.profile.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(padding.left)
            make.top.equalTo(self.name.snp_bottom).inset(-5)
        }
        self.edit.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-padding.right)
            make.top.equalTo(self.cover.snp_bottom).inset(-5)
            make.width.equalTo(90)
            make.height.equalTo(28)
        }
        self.location.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(padding.left)
            make.top.equalTo(self.profile.snp_bottom).inset(-5)
        }
        self.homepage.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.location.snp_right).inset(-5)
            make.top.equalTo(self.profile.snp_bottom).inset(-5)
        }
        self.pointNumber.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(padding.left)
            make.top.equalTo(self.location.snp_bottom).inset(-5)
        }
        self.topicCount.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.pointNumber.snp_right).inset(-5)
            make.top.equalTo(self.location.snp_bottom).inset(-5)
        }
        self.topicType.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.pointNumber.snp_bottom).inset(-10)
            make.left.equalTo(padding.left)
            make.right.equalTo(-padding.right)
//            make.height.equalTo(10)
        }
        self.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
            make.bottom.equalTo(self.topicType.snp_bottom).inset(-8)
            make.width.equalTo(UIScreen.mainScreen().bounds.width)
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
