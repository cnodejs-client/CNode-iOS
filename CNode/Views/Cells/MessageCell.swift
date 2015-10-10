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

class MessageCell: UITableViewCell {

    var name: UILabel = UILabel()
    var title: UILabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.title)
        
        // 名称
        self.name.textColor = UIColor.grayColor()
        self.name.font = UIFont.systemFontOfSize(14)
        // 标题
        self.title.numberOfLines = 0
        self.title.font = UIFont.boldSystemFontOfSize(16)

        // top -> left -> bottom -> right
        let padding: UIEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 8)

        self.name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(padding.left)
            make.right.equalTo(-padding.right)
        }
        self.title.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.name.snp_bottom).inset(-5)
            make.left.equalTo(padding.left)
            make.right.equalTo(-padding.right)
        }
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
            make.bottom.equalTo(self.title.snp_bottom).inset(-padding.bottom)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(data: Message) -> CGFloat {
        self.title.text = data.topic?.title
        self.name.text = "\(data.author!.loginname!) 回复了该话题："
        self.setNeedsLayout()
        return 0
    }
}
