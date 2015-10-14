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

class TopicContentCell: UITableViewCell, UIWebViewDelegate {
    
    var tableView: UITableView?
    
    var titleLabel: UILabel = UILabel()
    var content: UIWebView = UIWebView()
    var webViewHeight = CGFloat.min
    var avatar: UIImageView = UIImageView()
    var author: UILabel = UILabel()
    var create_at: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.content)
        self.contentView.addSubview(self.avatar)
        self.contentView.addSubview(self.author)
        self.contentView.addSubview(self.create_at)
        
        // 标题
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.boldSystemFontOfSize(16)
        // 内容
        self.content.delegate = self
        self.content.opaque = false
        self.content.scrollView.scrollEnabled = false
//        self.content.backgroundColor = UIColor.blueColor()
        // 头像
        self.avatar.backgroundColor = UIColor.blueColor()
        self.avatar.multipleTouchEnabled = true
        self.avatar.userInteractionEnabled = true
        // 作者
        self.author.textColor = UIColor.grayColor()
        self.author.font = UIFont.systemFontOfSize(14)
        // 日期
        self.create_at.textColor = UIColor.grayColor()
        self.create_at.font = UIFont.systemFontOfSize(14)
        
        // top -> left -> bottom -> right
        let padding: UIEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 8)
        
        self.avatar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.right.equalTo(-padding.right)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(padding.left)
            make.right.equalTo(self.avatar.snp_left).inset(-8)
        }
        self.content.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleLabel.snp_bottom)
            make.left.equalTo(padding.left)
            make.right.equalTo(self.avatar.snp_left).inset(-8)
            make.height.equalTo(50)
        }
        self.author.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.content.snp_bottom).inset(-5)
            make.left.equalTo(padding.left)
        }
        self.create_at.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.author.snp_right).inset(-5)
            make.centerY.equalTo(self.author)
        }
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
            make.bottom.equalTo(self.author.snp_bottom).inset(-padding.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(tableView: UITableView, data: Topic) -> CGFloat {
        self.tableView = tableView
        self.content.loadHTMLString(html(data.content!), baseURL: NSURL(string: URLs.baseURL))
        
        self.titleLabel.text = data.title
        self.author.text = data.author?.loginname
        self.create_at.text = data.create_at
        self.avatar.sd_setImageWithURL(NSURL(string: data.author!.avatar_url!))
        
        self.setNeedsLayout()
        return 0
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let height = webView.scrollView.contentSize.height
        print("\(height) \(webViewHeight)")
        if height == webViewHeight {
            return
        }
        webViewHeight = height
        self.content.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(height)
        }
        // 重新reload第一个Cell
        self.tableView?.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func html(body: String) -> String {
        return "<!DOCTYPE html>" +
        "<html>" +
        "<head>" +
        "</head>" +
            "<body>" +
                body +
            "</body>" +
        "</html>"
    }
}
