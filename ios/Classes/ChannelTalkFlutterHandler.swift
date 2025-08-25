import Flutter
import UIKit
import ChannelIOFront

public class ChannelTalkFlutterHandler: NSObject, ChannelPluginDelegate {
    var channel : FlutterMethodChannel
    
    init (channel: FlutterMethodChannel) {
        self.channel = channel
    }


    public func onShowMessenger() {
        channel.invokeMethod("onShowMessenger", arguments: nil)
    }

    public func onHideMessenger() {
        channel.invokeMethod("onHideMessenger", arguments: nil)
    }

    public func onChatCreated(chatId: String) {
        channel.invokeMethod("onChatCreated", arguments: chatId)
    }

    public func onBadgeChanged(unread: Int, alert: Int) {
        var args = [String: Any]()
        args["unread"] = unread
        args["alert"] = alert

        channel.invokeMethod("onBadgeChanged", arguments: args)
    }

    public func onFollowUpChanged(data: [String : Any]) {
        channel.invokeMethod("onFollowUpChanged", arguments:data)
    }

    public func onUrlClicked(url: URL) -> Bool {
        if (!url.absoluteString.contains("gada.worksmate.co.kr")) return false

        DispatchQueue.main.async { [weak self] in
            ChannelIO.hideMessenger()
            ChannelIO.hidePopup()
            
            // 메신저가 닫힌 후 잠시 대기하고 이벤트 호출
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self?.channel.invokeMethod("onUrlClicked", arguments: url.absoluteString)
            }
        }
        return true
    }

    public func onPopupDataReceived(event: PopupData) {
        channel.invokeMethod("onPopupDataReceived", arguments: event.toJson())
    }

}
