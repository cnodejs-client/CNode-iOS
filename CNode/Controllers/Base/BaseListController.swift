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
import MJRefresh

// MAKE: 通过泛型快速创建列表的父类
class BaseListController<T>: UITableViewController {
    
    init() {
        super.init(style: .Plain)
    }
    
    var loadStatusView: NKLoadStatusView = NKLoadStatusView()

    var dataSource: [T] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // 下拉刷新
        let header = MJRefreshNormalHeader { () -> Void in
            self.tableView.footer.resetNoMoreData()
            self.loadData(ApiClient.PAGE_FIRST)
            self.loadStatusView.show(self.dataSource.count == 0 ? .Loading : .Default)
        }
        // 隐藏时间
        header.lastUpdatedTimeLabel!.hidden = true
        // 隐藏状态
        header.stateLabel!.hidden = true
        // 上拉加载
        let footer = MJRefreshAutoNormalFooter { () -> Void in
            self.loadData(self.page())
        }
        footer.refreshingTitleHidden = true
        footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.tableView.header = header
        self.tableView.footer = footer
        // 不显示多余的分割线
        self.tableView.tableFooterView = UIView()
        // 加载状态视图
        self.loadStatusView = NKLoadStatusView(frame: self.view.bounds)
        self.view.addSubview(self.loadStatusView)
        
        self.tableView.separatorColor = Theme.color.separatorColor()
    }
    
    // MAKE: TableView数量默认为dataSource.count
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    // MAKE: 首次进入时刷新数据
    func firstRefreshing() {
        self.loadStatusView.show(self.dataSource.count == 0 ? .Loading : .Default)
        // 延时0.3秒后执行加载数据操作，延时是为了Loading不会因为加载速度过快造成一闪而过的不好体验
        self.delay(0.3) { () -> () in
            self.loadData(ApiClient.PAGE_FIRST)
        }
    }

    // MAKE: 默认进入下拉刷新状态，如需要进入上拉加载状态请使用self.tableView.footer.beginRefreshing()
    func beginRefreshing() {
        self.tableView.header.beginRefreshing()
    }
    
    // MAKE: 默认会结束下拉刷新及上拉加载刷新状态
    func endRefreshing() {
        if (self.tableView.header.isRefreshing()) {
            self.tableView.header.endRefreshing()
        }
        if (self.tableView.footer.isRefreshing()) {
            self.tableView.footer.endRefreshing()
        }
        // 通知MJRefresh是否未全部加载
        if (!self.hasMore()) {
            self.tableView.footer.noticeNoMoreData()
        }
        self.loadStatusView.show(self.dataSource.count == 0 ? .Empty : .Default)
    }
    
    // MAKE: 加载数据
    func loadData(page: Int) {
        delay(1.5) { () -> () in
            self.endRefreshing()
        }
    }

    // MAKE: 当前页码（按照TableView的数量计算）
    func page() -> Int {
        var count = self.tableView(self.tableView, numberOfRowsInSection: 0)
        count -= self.ignoreCount()
        if (count > 0) {
            let page = count / pageSize()
            // 如果默认page是从1开始的，则page+1
            if (ApiClient.PAGE_FIRST == 1) {
                return page + 1
            }
            return page
        }
        return 0
    }
    
    // MAKE: 默认分页大小为ApiClient.PAGE_SIZE
    func pageSize() -> Int {
        return ApiClient.PAGE_SIZE
    }
    
    // MAKE: 数据是否已经加载完毕
    func hasMore() -> Bool {
        var count = self.dataSource.count
        count -= self.ignoreCount()
        if (count % self.pageSize() != 0 || (count == 0)) {
            return false
        }
        return true
    }
    
    // MAKE: 忽略数（如果在头部插入了其他Cell，但又要保持分布正确，则添加相应的忽略数）
    func ignoreCount() -> Int {
        return 0
    }
}
