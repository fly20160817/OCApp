//
//  TimerManager.swift
//  OneMii
//
//  Created by fly on 2024/8/19.
//

import Foundation

@objcMembers open class TimerManager: NSObject
{
    // 计时器的时间间隔
    private var timerInterval: TimeInterval
    
    // 计时器触发时执行的动作
    private var timerAction: () -> Void
    
    // 计时器
    private lazy var timer: Timer? = {
        
        // 这里用的是 weakSelf，不要让 Timer 强引用 self， 这样 self 就能正常释放了，self 释放的时候，手动释放 Timer
        let timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] _ in
            // 当计时器触发时，调用指定的动作
            self?.timerAction()
        }
        // 初始时将计时器的触发时间设置为遥远的未来，使其不会立即触发
        timer.fireDate = Date.distantFuture
        return timer
    }()
    
    
    
    /// 初始化一个新的 `TimerManager` 实例
    /// - Parameters:
    ///   - interval: 计时器的时间间隔，单位是秒。
    ///   - action: 计时器触发时执行的闭包。
    init(interval: TimeInterval, action: @escaping () -> Void) {
        self.timerInterval = interval
        self.timerAction = action
    }
    
    deinit {
        
        print("\(self)销毁咯")
        
        // self 释放的时候，手动释放 Timer
        stopTimer()
    }
    
    
    
    /// 启动计时器
    func startTimer()
    {
        //启动定时器 触发时间  ([NSDate distantPast]随机获取一个遥远的过去时间)
        timer?.fireDate = Date.distantPast
    }
    
    /// 暂停计时器
    func pauseTimer()
    {
        //停止定时器 触发时间  ([NSDate distantFuture]随机获取一个遥远的未来时间)
        //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
        timer?.fireDate = Date.distantFuture
    }
    
    /// 关闭计时器  (由本类来管理timer的销毁，本类销毁时调用此方法)(只让内部调用，不然外界调用了，再去调startTimer就不起作用了)
    private func stopTimer()
    {
        //将timer从当前的RunLoop中remove掉
        timer?.invalidate()
        timer = nil
    }
    
    
}

