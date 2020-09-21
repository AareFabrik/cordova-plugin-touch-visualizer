@objc(TouchVisualizerSwift) class TouchVisualizerSwift : CDVPlugin {
    
    var savedArgs :[Any] = [] ;

    @objc(start:)
    func start(command: CDVInvokedUrlCommand) {
      var pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR
      )
        
        savedArgs = command.arguments ??  [];
        let config = getConfigFromArgs(args:savedArgs);
        Visualizer.start(config)
        
      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK
      )
    

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }

  @objc(stop:)
  func stop(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

      Visualizer.stop()

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK
      )
    

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
    

    @objc(isEnabled:)
    func isEnabled(command: CDVInvokedUrlCommand) {
      var pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR
      )

      let enabled = Visualizer.isEnabled()

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: enabled
      )
    

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
    
    func getConfigFromArgs(args: [Any]) -> Configuration {

        let hexRGBAColor = args.count >= 1 && ((args[0] as? String) != nil) ? args[0] as! String : "#77AAEECC"
        let showsTimer = args.count >= 2 && ((args[1] as? Bool) != nil) ? args[1] as! Bool : false
        let showsTouchRadius = args.count >= 3 && ((args[2] as? Bool) != nil) ? args[2] as! Bool: false
        let showsLog = args.count >= 4 && ((args[3] as? Bool) != nil) ? args[3] as! Bool: false

        var config = Configuration()
        config.color = UIColor(hexaRGBA: hexRGBAColor)
        config.showsTimer = showsTimer
        config.showsTouchRadius = showsTouchRadius
        config.showsLog = showsLog
        
        return config;
  }
}

extension UIColor {
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }

    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }

    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}
