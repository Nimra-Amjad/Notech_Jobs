import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "9a751e9c74944656868048d1f9e40693";
const token =
    "007eJxTYJg812n2459V024xmMTr+k5qrlhRPuNErUvo/b/aCw8VSEgoMFgmmpsaplomm5tYmpiYmZpZmFkYmFikGKZZppoYmFkaV6+uTWkIZGSIDVjOyMgAgSA+C0NJanEJAwMATHse2w==";
const channel = "test";

class VideoCallingScreen extends StatefulWidget {
  @override
  _VideoCallingScreenState createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(token, channel, null, 0);
  }

  bool localaudio = true;
  bool localvideo = true;
  bool remoteaudio = true;
  bool remotevideo = true;
  bool muted = false;

  enableordisablelocalVideo() async {
    if (localvideo) {
      await _engine.muteLocalVideoStream(true);
      localvideo = false;
    } else {
      await _engine.muteLocalVideoStream(false);
      localvideo = true;
    }
  }

  enableordisablelocalaudio() async {
    if (localaudio) {
      await _engine.muteLocalAudioStream(true);
      localaudio = false;
    } else {
      await _engine.muteLocalAudioStream(false);
      localaudio = true;
    }
  }

  enableordisableremoteVideo() async {
    if (remotevideo) {
      await _engine.muteAllRemoteVideoStreams(true);
      remotevideo = false;
    } else {
      await _engine.muteAllRemoteVideoStreams(false);
      remotevideo = true;
    }
  }

  enableordisableremoteaudio() async {
    if (remoteaudio) {
      await _engine.muteAllRemoteAudioStreams(true);
      remoteaudio = false;
    } else {
      await _engine.muteAllRemoteAudioStreams(false);
      remoteaudio = true;
    }
  }

  onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  onSwitchCamera() {
    _engine.switchCamera();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: localvideo,
            child: Container(
              width: double.infinity,
              height: 300,
              child: Center(
                child: _localUserJoined
                    ? RtcLocalView.SurfaceView()
                    : CircularProgressIndicator(),
              ),
            ),
          ),
          Visibility(
            visible: remotevideo,
            child: Container(
              width: double.infinity,
              height: 300,
              child: _remoteVideo(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  localvideo
                      ? Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await enableordisablelocalVideo();
                              setState(() {
                                localvideo != localvideo;
                              });
                            },
                            icon: Icon(Icons.videocam),
                            color: Colors.black,
                          ),
                        )
                      : Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await enableordisablelocalVideo();
                              setState(() {
                                localvideo = localvideo;
                              });
                            },
                            icon: Icon(Icons.videocam_off),
                            color: Colors.black,
                          ),
                        ),
                  localaudio
                      ? Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await enableordisablelocalaudio();
                              setState(() {
                                localaudio != localaudio;
                              });
                            },
                            icon: Icon(Icons.mic),
                            color: Colors.black,
                          ),
                        )
                      : Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await enableordisablelocalaudio();
                              setState(() {
                                localaudio != localaudio;
                              });
                            },
                            icon: Icon(Icons.mic_off_sharp),
                            color: Colors.black,
                          ),
                        ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        onCallEnd(context);
                      },
                      icon: Icon(Icons.call_end),
                      color: Color.fromARGB(255, 255, 55, 55),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        onSwitchCamera();
                      },
                      icon: Icon(Icons.switch_camera_sharp),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: channel,
      );
    } else {
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
