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

class TopicDetailController: BaseListController<Reply> {
    
    init(data: Topic) {
        super.init()
        self.topic = data
        self.topicId = self.topic?.id
    }

    var topicId: String?
    var topic: Topic?
    var topicContentCell: TopicContentCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TITLE_TOPIC_DETAIL".localized
        
        self.tableView.registerClass(ReplyCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.firstRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadData(page: Int) {
        let success = {
            (data: Topic) -> Void in
            // 下拉刷新时清空数据源
            if (page == ApiClient.PAGE_FIRST) {
                self.dataSource = []
                self.dataSource.append(Reply())
            }
            self.dataSource += data.replies!
            // 停止刷新中...
            self.endRefreshing()
            self.tableView.reloadData()
        };
        let failure = {
            (code: Int, message: String) -> Void in
            self.endRefreshing()
        };
        // 获取话题详情
        ApiClient.topicDetail(topicId!, success: success, failure: failure)
    }
    
    override func ignoreCount() -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            if (topicContentCell == nil) {
                topicContentCell = TopicContentCell()
            }
            topicContentCell!.bind(tableView, data:topic!)
            return topicContentCell!
        }
        let cell: ReplyCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ReplyCell
        let reply: Reply = self.dataSource[indexPath.row]
        cell.bind(reply)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false
        
    }
}
