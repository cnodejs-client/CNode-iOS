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

public enum LoadStatus {
    case Default
    case Loading
    case Empty
    case Error
}

class NKLoadStatusView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.indicatorView.frame = frame
        self.emptyView.frame = frame
        self.errorView.frame = frame
        self.retryView.frame = frame
        self.addSubview(self.indicatorView)
        self.addSubview(self.emptyView)
        self.addSubview(self.errorView)
        self.addSubview(self.retryView)
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var loadStatus: LoadStatus = .Loading
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var emptyView: UILabel = UILabel()
    var errorView: UILabel = UILabel()
    var retryView: UIButton = UIButton()

    func show(status: LoadStatus) {
        show(status, message: "空空如也~", retry: "刷新试试")
    }

    func show(status: LoadStatus, message: String, retry: String) {
        self.hidden = false
        self.indicatorView.hidden = true
        self.indicatorView.stopAnimating()
        self.emptyView.hidden = true
        self.errorView.hidden = true
        self.retryView.hidden = true
        switch (status) {
        case .Default:
            self.hidden = true
            break
        case .Loading:
            self.indicatorView.hidden = false
            self.indicatorView.startAnimating()
            break
        case .Empty:
            self.emptyView.hidden = false
            self.retryView.hidden = false
            if (message.characters.count > 0) {
                self.setEmptyText(message)
            }
            break
        case .Error:
            self.errorView.hidden = false
            self.retryView.hidden = false
            if (message.characters.count > 0) {
                self.setErrorText(message)
            }
            break
        }
        if (retry.characters.count > 0) {
            self.setRetryText(retry)
        }
        self.loadStatus = status
    }
    
    func setRetryText(text: String) {
        retryView.setTitle(text, forState: UIControlState.Normal)
    }
    
    func setEmptyText(text: String) {
        self.emptyView.text = text
    }
    
    func setErrorText(text: String) {
        self.errorView.text = text
    }
}