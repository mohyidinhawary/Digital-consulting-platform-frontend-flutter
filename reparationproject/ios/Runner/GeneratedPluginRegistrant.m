//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<agora_rtc_engine/AgoraRtcNgPlugin.h>)
#import <agora_rtc_engine/AgoraRtcNgPlugin.h>
#else
@import agora_rtc_engine;
#endif

#if __has_include(<image_picker_ios/FLTImagePickerPlugin.h>)
#import <image_picker_ios/FLTImagePickerPlugin.h>
#else
@import image_picker_ios;
#endif

#if __has_include(<iris_event/IrisEventPlugin.h>)
#import <iris_event/IrisEventPlugin.h>
#else
@import iris_event;
#endif

#if __has_include(<libphonenumber_plugin/FLTLibphonenumberPlugin.h>)
#import <libphonenumber_plugin/FLTLibphonenumberPlugin.h>
#else
@import libphonenumber_plugin;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<shared_preferences_foundation/SharedPreferencesPlugin.h>)
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#else
@import shared_preferences_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AgoraRtcNgPlugin registerWithRegistrar:[registry registrarForPlugin:@"AgoraRtcNgPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [IrisEventPlugin registerWithRegistrar:[registry registrarForPlugin:@"IrisEventPlugin"]];
  [FLTLibphonenumberPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTLibphonenumberPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
}

@end
