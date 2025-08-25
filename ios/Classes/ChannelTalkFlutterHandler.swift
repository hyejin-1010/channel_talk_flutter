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
        print("heidi test 01")
        DispatchQueue.main.async {
            print("heidi test 02")
            ChannelIO.hideMessenger()
            ChannelIO.hidePopup()
            print("heidi test 03")
            channel.invokeMethod("onUrlClicked", arguments: url.absoluteString)
            print("heidi test 04")
        }
        print("heidi test 05")
        return true
    }

    public func onPopupDataReceived(event: PopupData) {
        channel.invokeMethod("onPopupDataReceived", arguments: event.toJson())
    }

}
