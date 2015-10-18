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
import XLPagerTabStrip

enum TopicListFlag {
    case All    // 全部
    case Good   // 精华
    case Share  // 分享
    case Ask    // 问答
    case Job    // 招聘
}

class TopicListController: BaseListController<Topic> {

    var flag: TopicListFlag = TopicListFlag.All

    init(flag: TopicListFlag) {
        self.flag = flag
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var btnPublish: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnPublish = UIBarButtonItem(title: "ACTION_PUBLISH_TOPIC".localized, style: .Plain, target: self, action: "publishTopic:")
        self.navigationItem.rightBarButtonItem = btnPublish
        
        self.tableView.registerClass(TopicCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.firstRefreshing()
    }
    
    func publishTopic(sender: UIBarButtonItem) {
        let controller: PublishTopicController = PublishTopicController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    override func loadData(page: Int) {
        let success = {
            (data: [Topic]) -> Void in
            // 下拉刷新时清空数据源
            if (page == ApiClient.PAGE_FIRST) {
                self.dataSource = []
            }
            self.dataSource += data
            // 停止刷新中...
            self.endRefreshing()
            self.tableView.reloadData()
        };
        let failure = {
            (code: Int, message: String) -> Void in
            self.endRefreshing()
        };
        switch (flag) {
            // 全部
        case .All:
            ApiClient.topicList(page, tab: "all", success: success, failure: failure)
            break
            // 精华
        case .Good:
            ApiClient.topicList(page, tab: "good", success: success, failure: failure)
            break
            // 分享
        case .Share:
            ApiClient.topicList(page, tab: "share", success: success, failure: failure)
            break
            // 问答
        case .Ask:
            ApiClient.topicList(page, tab: "ask", success: success, failure: failure)
            break
            // 招聘
        case .Job:
            ApiClient.topicList(page, tab: "job", success: success, failure: failure)
            break
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TopicCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TopicCell
        let topic: Topic = self.dataSource[indexPath.row]
        cell.bind(topic)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false
        let topic: Topic = self.dataSource[indexPath.row]
        let controller: TopicDetailController = TopicDetailController(data: topic)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}