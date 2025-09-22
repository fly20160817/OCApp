//
//  Logger.swift
//  OneMii
//
//  Created by fly on 2024/8/19.
//

import Foundation

@objc public enum LogLevel: Int {
    case debug = 0      // 调试信息
    case info           // 普通信息
    case warning        // 警告信息
    case error          // 错误信息
    case critical       // 严重错误信息

    // 返回日志等级的字符串描述
    var description: String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        case .critical: return "CRITICAL"
        }
    }
}

@objcMembers open class Logger: NSObject
{
    // 当前日志等级。只有高于或等于此等级的日志才会被打印或保存。
    // 默认值为 `.info`。
    static var logLevel: LogLevel = .info
    
    // 是否启用日志文件保存功能。
    // 如果启用，所有记录的日志将被保存到文件中。
    // 默认值为 `false`。
    static var isLogFileEnabled: Bool = false
    
    
    
    // 设置日志文件夹路径
    private class var logDirectoryPath: String {
        // 使用 NSSearchPathForDirectoriesInDomains 获取文档目录路径
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
        // 创建 "logs" 文件夹的原因，是因为日志名字是日期格式，不固定的，删除的时候不能根据名字来删除，要判断名字的前缀和后缀(不然会误删其他的同级文件)，一旦以后修改了前缀或者后缀，删除的方法忘记改了就删除不掉了，把日志放入单独的"logs" 文件夹就不用判断前缀后缀了。
        let logDirectory = (documentDirectory as NSString).appendingPathComponent("logs")
        return logDirectory
    }
    
    // 设置日志文件路径
    private class var logFilePath: String {
        let logDirectoryURL = URL(fileURLWithPath: logDirectoryPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        return logDirectoryURL.appendingPathComponent("app_log_\(dateString).txt").path
    }
    
}



// MARK: - public Methods

public extension Logger
{
    /// 记录日志信息的方法。
    ///
    /// 将 file、function 和 line 这三个参数写成方法参数，而不是直接在方法内部获取，主要是为了在调用时能够捕获到调用者所在的位置。如果直接在方法内部获取这些参数，那么它们将总是反映日志记录方法本身所在的位置，而不是调用日志方法的位置。
    ///
    /// - Parameters:
    ///   - message: 要记录的日志信息内容。
    ///   - level: 日志的严重程度，默认为 `.info`。
    ///   - file: 不能手动传递，自动捕获日志记录所在的源文件名，默认为调用此方法的文件名。
    ///   - function: 不能手动传递，自动捕获日志记录所在的函数名，默认为调用此方法的函数名。
    ///   - line: 不能手动传递，自动捕获日志记录所在的代码行号，默认为调用此方法的代码行号。
    class func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        // 检查日志等级，只有高于或等于当前设置的日志等级的日志才会被记录。
        guard level.rawValue >= logLevel.rawValue else { return }
        
        // 获取文件名（去除路径，仅保留文件名）
        let fileName = (file as NSString).lastPathComponent
        
        // 构建日志消息内容，包含日志等级、文件名、行号、函数名和消息内容
        let logMessage = "[\(level.description)] \(fileName):\(line) \(function): \(message)"
        
        // 将日志消息打印到控制台
        print(logMessage)
        
        // 如果启用了日志文件保存功能，则将日志消息保存到文件中 (拼上换行，不然每条日志都连在一起了)
        if isLogFileEnabled
        {
            saveLogToFile(logMessage + "\n")
        }
    }
    
    /// 获取日志文件的路径。
    ///
    /// 此方法返回日志文件的完整路径，方便外部进行上传、读取或其他处理操作。
    ///
    /// - Returns: 返回当前日志文件的完整路径。
    class func getLogFilePath() -> String
    {
        return logFilePath
    }
    
    /// 删除日志文件的方法。
    ///
    /// 此方法用于在需要时删除当前日志文件，通常是在上传或处理完日志后清理日志文件时使用。
    class func deleteLogFile()
    {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: logFilePath)
        {
            try? fileManager.removeItem(atPath: logFilePath)
        }
    }
}



// MARK: - Private Methods

private extension Logger
{
    /// 保存日志信息到文件的方法。
    ///
    /// 此方法将日志消息内容追加到日志文件中，如果文件不存在则会自动创建。
    ///
    /// - Parameter logMessage: 要保存的日志消息内容。
    class func saveLogToFile(_ logMessage: String)
    {
        // 根据当前日期生成日志文件路径
        let fileURL = URL(fileURLWithPath: logFilePath)
        
        // 将日志消息内容转换为数据
        if let data = logMessage.data(using: .utf8)
        {
            // 确保日志文件所在的目录存在
            let logDirectoryURL = URL(fileURLWithPath: logDirectoryPath)
            if !FileManager.default.fileExists(atPath: logDirectoryURL.path)
            {
                // 如果目录不存在，则创建目录
                do {
                    try FileManager.default.createDirectory(at: logDirectoryURL, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("创建日志目录失败: \(error)")
                    return
                }
            }
            
            // 检查日志文件是否存在
            if FileManager.default.fileExists(atPath: logFilePath)
            {
                // 如果日志文件存在，则打开文件并将新日志追加到文件末尾
                do {
                    let fileHandle = try FileHandle(forWritingTo: fileURL)
                    fileHandle.seekToEndOfFile()  // 移动到文件末尾
                    fileHandle.write(data)        // 写入日志数据
                    fileHandle.closeFile()        // 关闭文件
                } catch {
                    print("写入日志文件失败: \(error)")
                }
            } else
            {
                // 如果日志文件不存在，则创建新文件并写入日志内容
                do {
                    try data.write(to: fileURL, options: .atomic)
                } catch {
                    print("创建日志文件失败: \(error)")
                }
            }
        }
        
        // 清理旧日志文件
        cleanOldLogFiles()
    }
    
    /// 清理旧日志文件的方法。
    ///
    /// 此方法删除日志文件夹中早于今天的日志文件，以节省存储空间。
    class func cleanOldLogFiles()
    {
        let fileManager = FileManager.default
        let logDirectoryURL = URL(fileURLWithPath: logDirectoryPath)
        
        do {
            // 获取目录中所有文件的 URL
            let files = try fileManager.contentsOfDirectory(at: logDirectoryURL, includingPropertiesForKeys: [.creationDateKey])
            let now = Date()
            
            for file in files
            {
                // 获取文件的创建日期
                if let attributes = try? fileManager.attributesOfItem(atPath: file.path),
                   let creationDate = attributes[.creationDate] as? Date
                {
                    // 计算文件的日期（去除时间）
                    let calendar = Calendar.current
                    let fileDate = calendar.startOfDay(for: creationDate)
                    let today = calendar.startOfDay(for: now)
                    
                    // 删除早于今天的日志文件
                    if fileDate < today
                    {
                        try fileManager.removeItem(at: file)
                        print("已删除旧日志文件: \(file.path)")
                    }
                }
            }
        } catch {
            print("清理旧日志文件失败: \(error)")
        }
    }
}



/*
 // 使用示例

 // 配置日志等级和启用文件保存功能
 Logger.logLevel = .debug
 Logger.isLogFileEnabled = true

 // 记录不同等级的日志
 Logger.log("这是一个调试信息", level: .debug)
 Logger.log("这是普通信息", level: .info)
 Logger.log("这是警告信息", level: .warning)
 Logger.log("这是错误信息", level: .error)
 Logger.log("这是严重错误信息", level: .critical)

 // 获取当前日志文件路径
 let currentLogFilePath = Logger.getLogFilePath()
 print("当前日志文件路径: \(currentLogFilePath)")

 */


