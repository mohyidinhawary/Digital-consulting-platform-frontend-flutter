//
//
//
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import '../../app_brain.dart';
//
// class VideoCallScreen extends StatefulWidget {
//   const VideoCallScreen({Key? key}) : super(key: key);
//
//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }
//
// class _VideoCallScreenState extends State<VideoCallScreen> {
//   late int _remoteUid = 0;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     initAgora();
//     super.initState();
//   }
//
//   void dispose() {
//     super.dispose();
//     _engine.leaveChannel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Center(
//             child: _renderRemoteVideo(),
//           ),
//           SafeArea(
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(150.0),
//                 child: Container(
//                     height: 150, width: 150, child: _renderLocalPreview()),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 25.0, right: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(true);
//                       },
//                       icon: Icon(
//                         Icons.call_end,
//                         size: 44,
//                         color: Colors.redAccent,
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//     _engine = await RtcEngine.create(AgoraManager.appId!);
//     _engine.enableVideo();
//     _engine.setEventHandler(
//       RtcEngineEventHandler(
//         joinChannelSuccess: (String?channel, int uid, int elapsed) {
//           print('local user $uid joined successfully');
//         },
//         userJoined: (int uid, int elapsed) {
//           print('remote user $uid joined successfully');
//           setState(() => _remoteUid = uid);
//         },
//         userOffline: (int uid, UserOfflineReason reason) {
//           print('remote user $uid left call');
//           setState(() => _remoteUid = 0);
//           Navigator.of(context).pop(true);
//         },
//       ),
//     );
//     await _engine.joinChannel(
//         AgoraManager.token,  AgoraManager.channelName!, null,0);
//   }
//
//   Widget _renderLocalPreview() {
//     return RtcLocalView.SurfaceView();
//   }
// //remote User View
//
//   Widget _renderRemoteVideo() {
//     if (_remoteUid != 0) {
//       return RtcRemoteView.SurfaceView(
//         channelId: AgoraManager.channelName!,
//         uid: _remoteUid,
//       );
//     } else {
//       return Text(
//       'Calling …',
//       style: Theme.of(context).textTheme.headline6,
//     textAlign: TextAlign.center,
//     );
//     }
//     }
// }
//


import 'dart:async';


import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/constant.dart';
import '../widgets/calling_components/round_button.dart';
import '../widgets/calling_components/size_config.dart';

const appId = "905ffb97836c4fceafcf6d41ec2b5e29";
const token = "007eJxTYGix++CRaX8mmSet2WRudPrjNUzmE/7Y/DojV9lr914ooEKBwdLANC0tydLcwtgs2SQtOTUxLTnNLMXEMDXZKMk01cjSvW1XckMgI0NB2VxWRgYIBPE5GJIzEvPyUnPMGRgAs8og3w==";
const channel = "channel7";

void main() => runApp(const MaterialApp(home: VideoCallScreen()));

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted=false;


  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void dispose() {
    super.dispose();
    _engine.leaveChannel();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, defaultPadding*2),
          child: Stack(
            children: [
              Center(
                child: _remoteVideo(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: _localUserJoined
                        ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                        :  LoadingAnimationWidget.staggeredDotsWave(color: mintColor, size: 30),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Mic.svg",
                    ),
                    RoundedButton(
                      press: () { Navigator.of(context).pop(true);},
                      color: kRedColor,
                      iconColor: Colors.white,
                      iconSrc: "assets/icons/call_end.svg",
                    ),
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Volume.svg",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}