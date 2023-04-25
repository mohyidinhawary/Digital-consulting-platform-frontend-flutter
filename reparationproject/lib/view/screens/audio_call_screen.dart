//
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import '../../app_brain.dart';
//
// class AudioCallScreen extends StatefulWidget {
//   const AudioCallScreen({Key? key}) : super(key: key);
//
//   @override
//   _AudioCallScreenState createState() => _AudioCallScreenState();
// }
//
// class _AudioCallScreenState extends State<AudioCallScreen> {
//   late int _remoteUid = 0;
//   late RtcEngine _engine;
//
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }
//
//   @override
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
//         Container(
//         color: Colors.black87,
//         child: Center(
//           child: _remoteUid == 0
//               ? Text(
//           'Calling …',
//           style: TextStyle(color: Colors.white),
//         )
//             : Text(
//         'Calling with $_remoteUid',
//       ),
//     ),
//     ),
//     Align(
//     alignment: Alignment.bottomCenter,
//     child: Padding(
//     padding: const EdgeInsets.only(bottom: 25.0, right: 25),
//     child: Container(
//     height: 50,
//     color: Colors.black12,
//     child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//     IconButton(
//     onPressed: () {
//     Navigator.of(context).pop(true);
//     },
//     icon: Icon(
//     Icons.call_end,
//     size: 44,
//     color: Colors.redAccent,
//     )),
//     ],
//     ),
//     ),
//     ),
//     ),
//     ],
//     ),
//     );
//   }
//
//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//     _engine = await RtcEngine.create(AgoraManager.appId!);
//     _engine.enableVideo();
//     _engine.setEventHandler(
//       RtcEngineEventHandler(
//         joinChannelSuccess: (String? channel, int uid, int elapsed) {
//           print('local user $uid joined successfully');
//         },
//         userJoined: (int uid, int elapsed) {
//           print('remote user $uid joined successfully');
//           setState(() => _remoteUid = uid);
//         },
//         userOffline: (int uid, UserOfflineReason reason) {
//           print('remote user $uid left call');
//           setState(() => _remoteUid = 0);
//           Navigator.of(context).pop();
//         },
//       ),
//     );
//     await _engine.joinChannel(
//         AgoraManager.token!, AgoraManager.channelName!, null, 0);
//   }
//
//   Widget _renderRemoteAudio() {
//     if (_remoteUid != 0) {
//       return Text(
//       'Calling with $_remoteUid',
//       style: TextStyle(color: Colors.white),
//     );
//     } else {
//     return Text(
//     'Calling …',
//     style: TextStyle(color: Colors.white),
//     );
//     }
//   }
// }

import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/constant.dart';
import '../widgets/calling_components/body.dart';
import '../widgets/calling_components/size_config.dart';

const appId = "905ffb97836c4fceafcf6d41ec2b5e29";
const token = "007eJxTYGix++CRaX8mmSet2WRudPrjNUzmE/7Y/DojV9lr914ooEKBwdLANC0tydLcwtgs2SQtOTUxLTnNLMXEMDXZKMk01cjSvW1XckMgI0NB2VxWRgYIBPE5GJIzEvPyUnPMGRgAs8og3w==";
const channel = "channel7";

void main() => runApp(const MaterialApp(home: AudioCallScreen()));

class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen({Key? key}) : super(key: key);

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {

  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;

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
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    // await _engine.enableVideo();
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
      body: Stack(
        children: [
          Body(),
          Center(
            child: _remoteAudio(),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteAudio() {
    if (_remoteUid != null) {
      return Text(
        'Calling with $_remoteUid',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calling    ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            LoadingAnimationWidget.staggeredDotsWave(color: blueColor, size: 30)
          ],
        ),
      );
    }
  }
}
