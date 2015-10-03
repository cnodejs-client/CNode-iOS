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

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // 类别ID 1-问答 2-分享 3-IT杂烩(综合) 4-站务 100-职业生涯 0-所有
        switch (flag) {
        case .All:
            ApiClient.topicList(page, tab: "all", success: success, failure: failure)
            break
        case .Good:
            ApiClient.topicList(page, tab: "good", success: success, failure: failure)
            break
        case .Share:
            ApiClient.topicList(page, tab: "share", success: success, failure: failure)
            break
        case .Ask:
            ApiClient.topicList(page, tab: "ask", success: success, failure: failure)
            break
        case .Job:
            ApiClient.topicList(page, tab: "job", success: success, failure: failure)
            break
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let topic: Topic = self.dataSource[indexPath.row]

        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel!.text = topic.title
        cell.detailTextLabel!.text = topic.content
        cell.accessoryType = .DisclosureIndicator
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false

        //        let controller: TweetDetailController = TweetDetailController(nibName: nil, bundle: nil)
        //        controller.hidesBottomBarWhenPushed = true
        //        self.navigationController?.pushViewController(controller, animated: true)
    }

}