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
    case All
    case Good
    case Share
    case Ask
    case Job
}

class TopicListController: BaseListController<Topic>, XLPagerTabStripChildItem {

    var flag: TopicListFlag = TopicListFlag.All

    init(flag: TopicListFlag) {
        self.flag = flag
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var heights: [Int: CGFloat] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(TopicCell.self, forCellReuseIdentifier: "Cell")
        self.firstRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func titleForPagerTabStripViewController(pagerTabStripViewController: XLPagerTabStripViewController!) -> String! {
        switch (flag) {
        case .All:
            return "TAB_TOPIC_LIST_ALL".localized
        case .Good:
            return "TAB_TOPIC_LIST_GOOD".localized
        case .Share:
            return "TAB_TOPIC_LIST_SHARE".localized
        case .Ask:
            return "TAB_TOPIC_LIST_ASK".localized
        case .Job:
            return "TAB_TOPIC_LIST_JOB".localized
        }
    }

    override func loadData(page: Int) {
        let success = {
            (data: [Topic]) -> Void in
            // 下拉刷新时清空数据源
            if (page == 0) {
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
        var cell: TopicCell? = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TopicCell
        if (cell == nil) {
            print("创建cell")
            cell = TopicCell()
        }
        let topic: Topic = self.dataSource[indexPath.row]

//        let cell = TopicCell()
        let height = cell!.bind(topic)
        self.heights.updateValue(height, forKey: indexPath.row)
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false

        //        let controller: TweetDetailController = TweetDetailController(nibName: nil, bundle: nil)
        //        controller.hidesBottomBarWhenPushed = true
        //        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let h = heights[indexPath.row] {
            print("\(indexPath.row)|\(h)")
            return h
        }
//        let topic: Topic = self.dataSource[indexPath.row]
//        let cell = TopicCell()
//        let h2 = cell.bind(topic)
//        heights[indexPath.row] = h2
        return 44
    }

}