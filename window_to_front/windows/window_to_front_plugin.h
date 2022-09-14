#ifndef FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_
#define FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace window_to_front {

class WindowToFrontPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WindowToFrontPlugin(flutter::PluginRegistrarWindows *registrar);

  virtual ~WindowToFrontPlugin();

  // Disallow copy and assign.
  WindowToFrontPlugin(const WindowToFrontPlugin&) = delete;
  WindowToFrontPlugin& operator=(const WindowToFrontPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

  // The registrar for this plugin, for accessing the window.
  flutter::PluginRegistrarWindows *registrar_;
};

}  // namespace window_to_front

#endif  // FLUTTER_PLUGIN_WINDOW_TO_FRONT_PLUGIN_H_
Add the code to make the native functionality we created above available to the world of Flutter. First up, edit the window to front platform interface and add an activate() method, with a fallback implementation.

../window_to_front/lib/window_to_front_platform_interface.dart

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'window_to_front_method_channel.dart';

abstract class WindowToFrontPlatform extends PlatformInterface {
  /// Constructs a WindowToFrontPlatform.
  WindowToFrontPlatform() : super(token: _token);

  static final Object _token = Object();

  static WindowToFrontPlatform _instance = MethodChannelWindowToFront();

  /// The default instance of [WindowToFrontPlatform] to use.
  ///
  /// Defaults to [MethodChannelWindowToFront].
  static WindowToFrontPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WindowToFrontPlatform] when
  /// they register themselves.
  static set instance(WindowToFrontPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Replace getPlatformVersion() with the following activate() method
  Future<void> activate() {
    throw UnimplementedError('activate() has not been implemented.');
  }
}