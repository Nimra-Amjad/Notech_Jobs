// // import 'dart:async';

// // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // import 'package:agora_rtc_engine/rtc_engine.dart';
// // import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// // import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// // import 'package:flutter/material.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // const appId = "9a751e9c74944656868048d1f9e40693";
// // const token =
// //     "007eJxTYJg812n2459V024xmMTr+k5qrlhRPuNErUvo/b/aCw8VSEgoMFgmmpsaplomm5tYmpiYmZpZmFkYmFikGKZZppoYmFkaV6+uTWkIZGSIDVjOyMgAgSA+C0NJanEJAwMATHse2w==";
// // const channel = "test";

// // class VideoCallingScreen extends StatefulWidget {
// //   @override
// //   _VideoCallingScreenState createState() => _VideoCallingScreenState();
// // }

// // class _VideoCallingScreenState extends State<VideoCallingScreen> {
// //   int? _remoteUid;
// //   bool _localUserJoined = false;
// //   late RtcEngine _engine;

// //   @override
// //   void initState() {
// //     super.initState();
// //     initAgora();
// //   }

// //   Future<void> initAgora() async {
// //     // retrieve permissions
// //     await [Permission.microphone, Permission.camera].request();

// //     //create the engine
// //     _engine = await RtcEngine.create(appId);
// //     await _engine.enableVideo();
// //     _engine.setEventHandler(
// //       RtcEngineEventHandler(
// //         joinChannelSuccess: (String channel, int uid, int elapsed) {
// //           print("local user $uid joined");
// //           setState(() {
// //             _localUserJoined = true;
// //           });
// //         },
// //         userJoined: (int uid, int elapsed) {
// //           print("remote user $uid joined");
// //           setState(() {
// //             _remoteUid = uid;
// //           });
// //         },
// //         userOffline: (int uid, UserOfflineReason reason) {
// //           print("remote user $uid left channel");
// //           setState(() {
// //             _remoteUid = null;
// //           });
// //         },
// //       ),
// //     );

// //     await _engine.joinChannel(token, channel, null, 0);
// //   }

// //   bool localaudio = true;
// //   bool localvideo = true;
// //   bool remoteaudio = true;
// //   bool remotevideo = true;
// //   bool muted = false;

// //   enableordisablelocalVideo() async {
// //     if (localvideo) {
// //       await _engine.muteLocalVideoStream(true);
// //       localvideo = false;
// //     } else {
// //       await _engine.muteLocalVideoStream(false);
// //       localvideo = true;
// //     }
// //   }

// //   enableordisablelocalaudio() async {
// //     if (localaudio) {
// //       await _engine.muteLocalAudioStream(true);
// //       localaudio = false;
// //     } else {
// //       await _engine.muteLocalAudioStream(false);
// //       localaudio = true;
// //     }
// //   }

// //   enableordisableremoteVideo() async {
// //     if (remotevideo) {
// //       await _engine.muteAllRemoteVideoStreams(true);
// //       remotevideo = false;
// //     } else {
// //       await _engine.muteAllRemoteVideoStreams(false);
// //       remotevideo = true;
// //     }
// //   }

// //   enableordisableremoteaudio() async {
// //     if (remoteaudio) {
// //       await _engine.muteAllRemoteAudioStreams(true);
// //       remoteaudio = false;
// //     } else {
// //       await _engine.muteAllRemoteAudioStreams(false);
// //       remoteaudio = true;
// //     }
// //   }

// //   onCallEnd(BuildContext context) {
// //     Navigator.pop(context);
// //   }

// //   onSwitchCamera() {
// //     _engine.switchCamera();
// //   }

// //   // Create UI with local view and remote view
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Agora Video Call'),
// //       ),
// //       body: Column(
// //         children: [
// //           Visibility(
// //             visible: localvideo,
// //             child: Container(
// //               width: double.infinity,
// //               height: 300,
// //               child: Center(
// //                 child: _localUserJoined
// //                     ? RtcLocalView.SurfaceView()
// //                     : CircularProgressIndicator(),
// //               ),
// //             ),
// //           ),
// //           Visibility(
// //             visible: remotevideo,
// //             child: Container(
// //               width: double.infinity,
// //               height: 300,
// //               child: _remoteVideo(),
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: Container(
// //               width: double.infinity,
// //               height: 50,
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 children: [
// //                   localvideo
// //                       ? Container(
// //                           width: 40,
// //                           height: 40,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(20.0),
// //                             color: Colors.white,
// //                           ),
// //                           child: IconButton(
// //                             onPressed: () async {
// //                               await enableordisablelocalVideo();
// //                               setState(() {
// //                                 localvideo != localvideo;
// //                               });
// //                             },
// //                             icon: Icon(Icons.videocam),
// //                             color: Colors.black,
// //                           ),
// //                         )
// //                       : Container(
// //                           width: 40,
// //                           height: 40,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(20.0),
// //                             color: Colors.white,
// //                           ),
// //                           child: IconButton(
// //                             onPressed: () async {
// //                               await enableordisablelocalVideo();
// //                               setState(() {
// //                                 localvideo = localvideo;
// //                               });
// //                             },
// //                             icon: Icon(Icons.videocam_off),
// //                             color: Colors.black,
// //                           ),
// //                         ),
// //                   localaudio
// //                       ? Container(
// //                           width: 40,
// //                           height: 40,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(20.0),
// //                             color: Colors.white,
// //                           ),
// //                           child: IconButton(
// //                             onPressed: () async {
// //                               await enableordisablelocalaudio();
// //                               setState(() {
// //                                 localaudio != localaudio;
// //                               });
// //                             },
// //                             icon: Icon(Icons.mic),
// //                             color: Colors.black,
// //                           ),
// //                         )
// //                       : Container(
// //                           width: 40,
// //                           height: 40,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(20.0),
// //                             color: Colors.white,
// //                           ),
// //                           child: IconButton(
// //                             onPressed: () async {
// //                               await enableordisablelocalaudio();
// //                               setState(() {
// //                                 localaudio != localaudio;
// //                               });
// //                             },
// //                             icon: Icon(Icons.mic_off_sharp),
// //                             color: Colors.black,
// //                           ),
// //                         ),
// //                   Container(
// //                     width: 40,
// //                     height: 40,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(20.0),
// //                       color: Colors.white,
// //                     ),
// //                     child: IconButton(
// //                       onPressed: () {
// //                         onCallEnd(context);
// //                       },
// //                       icon: Icon(Icons.call_end),
// //                       color: Color.fromARGB(255, 255, 55, 55),
// //                     ),
// //                   ),
// //                   Container(
// //                     width: 40,
// //                     height: 40,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(20.0),
// //                       color: Colors.white,
// //                     ),
// //                     child: IconButton(
// //                       onPressed: () {
// //                         onSwitchCamera();
// //                       },
// //                       icon: Icon(Icons.switch_camera_sharp),
// //                       color: Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // Display remote user's video
// //   Widget _remoteVideo() {
// //     if (_remoteUid != null) {
// //       return RtcRemoteView.SurfaceView(
// //         uid: _remoteUid!,
// //         channelId: channel,
// //       );
// //     } else {
// //       return Text(
// //         'Please wait for remote user to join',
// //         textAlign: TextAlign.center,
// //       );
// //     }
// //   }
// // }

// // ignore_for_file: avoid_print, non_constant_identifier_names
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../components/buttons/quick_select_button.dart';
// import '../components/text/custom_text.dart';
// import '../components/utils/app_assets.dart';
// import '../components/utils/app_colors.dart';
// import '../components/utils/app_size.dart';
// import '../components/widgets/prompts.dart';

// const appId = "9a751e9c74944656868048d1f9e40693";
// const token =
//     "007eJxTYJg812n2459V024xmMTr+k5qrlhRPuNErUvo/b/aCw8VSEgoMFgmmpsaplomm5tYmpiYmZpZmFkYmFikGKZZppoYmFkaV6+uTWkIZGSIDVjOyMgAgSA+C0NJanEJAwMATHse2w==";
// const channel = "test";

// class VideoCallingScreen extends StatefulWidget {
//   final String? channelId, firstName, lastName, userType;
//   final Color? templateColor;
//   final bool? isAudioOnly, isAudioMuted, isVideoMuted;
//   const VideoCallingScreen(
//       {Key? key,
//       this.channelId,
//       this.firstName,
//       this.lastName,
//       this.templateColor,
//       this.isAudioMuted,
//       this.isAudioOnly,
//       this.isVideoMuted,
//       this.userType})
//       : super(key: key);

//   @override
//   State<VideoCallingScreen> createState() => _VideoCallingScreenState();
// }

// class _VideoCallingScreenState extends State<VideoCallingScreen> {
//   bool loader = false;
//   late final RtcEngine engine;
//   bool isUseFlutterTexture = false;
//   bool isUseAndroidSurfaceView = false;
//   bool isReadyPreview = false;
//   bool isJoined = false;
//   bool isMicUse = true,
//       isCameraUse = true,
//       isFlipCamera = true,
//       isLightUse = false;
//   bool isRemoteUserMuted = false;
//   String RemoteUserid = "";
//   String micIcon = AppAssets.micOn;
//   String cameraIcon = AppAssets.videoOn;
//   String lightIcon = AppAssets.lightOff;
//   String flipIcon = AppAssets.flipBack;
//   String callIcon = AppAssets.callDecline;
//   Set<int> remoteUid = {};

//   ChannelProfileType channelProfileType =
//       ChannelProfileType.channelProfileCommunication;

//   @override
//   void initState() {
//     super.initState();
//     initRtcEngine();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     if (isJoined) {
//       disposeRtcEngine();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           showDialog(
//               context: context,
//               builder: ((ctx) => PlaceholderDialog(
//                     icon: Icon(
//                       Icons.warning_amber,
//                       size: AppSize.iconSize * 2,
//                       color: Colors.red,
//                     ),
//                     title: "Do you really want to leave call?",
//                     actions: [
//                       QuickSelectButton(
//                         ontap: () {
//                           Navigator.pop(context);
//                         },
//                         btncolor: AppColors.blueColor,
//                         text: "Cancel",
//                       ),
//                       QuickSelectButton(
//                           ontap: () {
//                             if (isJoined) {
//                               disposeRtcEngine();

//                               // Navigator.of(context).pushAndRemoveUntil(
//                               //     MaterialPageRoute(
//                               //         builder: (context) =>
//                               //             const IconsCircle()),
//                               //     (Route<dynamic> route) => false);
//                               Navigator.pop(context);
//                             }
//                           },
//                           btncolor: AppColors.blueColor,
//                           text: "Confirm"),
//                     ],
//                   )));
//           return false;
//         },
//         child: Scaffold(
//             body: Stack(children: [
//           remoteUid.isNotEmpty
//               ? SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: List.of(remoteUid.map(
//                       (e) => GestureDetector(
//                         child: SizedBox(
//                           width: AppSize.screenWidth,
//                           height: AppSize.screenHeight,
//                           child: isRemoteUserMuted == true
//                               ? Container(
//                                   color: AppColors.primaryGrey,
//                                   child: Center(
//                                       child: Container(
//                                           height: AppSize.screenWidth / 1.5,
//                                           width: AppSize.screenWidth / 1.5,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: AppColors.blueLight,
//                                                   width: 10),
//                                               color: AppColors.blueLight
//                                                   .withOpacity(0.7),
//                                               borderRadius:
//                                                   const BorderRadius.all(
//                                                       Radius.circular(1000))),
//                                           child: Center(
//                                               child: CustomText(
//                                                   text: widget.firstName![0] +
//                                                       widget.lastName![0],
//                                                   fontSize:
//                                                       AppSize.screenWidth / 3,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontColor:
//                                                       AppColors.primaryGrey)))))
//                               : AgoraVideoView(
//                                   controller: VideoViewController.remote(
//                                     rtcEngine: engine,
//                                     canvas: VideoCanvas(
//                                       uid: e,
//                                     ),
//                                     connection: RtcConnection(
//                                       channelId: widget.channelId,
//                                     ),
//                                     useFlutterTexture: isUseFlutterTexture,
//                                     useAndroidSurfaceView:
//                                         isUseAndroidSurfaceView,
//                                   ),
//                                 ),
//                         ),
//                         onTap: () {
//                           focusEnable();
//                         },
//                       ),
//                     )),
//                   ),
//                 )
//               : GestureDetector(
//                   child: SizedBox(
//                     width: AppSize.screenWidth,
//                     height: AppSize.screenHeight,
//                     child: isCameraUse == false
//                         ? Container(
//                             color: AppColors.primaryGrey,
//                             child: Center(
//                                 child: Container(
//                                     height: AppSize.screenWidth / 1.5,
//                                     width: AppSize.screenWidth / 1.5,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: AppColors.blueLight,
//                                             width: 10),
//                                         color: AppColors.blueLight
//                                             .withOpacity(0.7),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(1000))),
//                                     child: Center(
//                                         child: CustomText(
//                                             text: widget.firstName![0] +
//                                                 widget.lastName![0],
//                                             fontSize: AppSize.screenWidth / 3,
//                                             fontWeight: FontWeight.bold,
//                                             fontColor:
//                                                 AppColors.primaryGrey)))))
//                         : AgoraVideoView(
//                             controller: VideoViewController(
//                               rtcEngine: engine,
//                               canvas: const VideoCanvas(
//                                 uid: 0,
//                               ),
//                               useFlutterTexture: isUseFlutterTexture,
//                               useAndroidSurfaceView: isUseAndroidSurfaceView,
//                             ),
//                           ),
//                   ),
//                   onTap: () {
//                     focusEnable();
//                   },
//                 ),
//           remoteUid.isNotEmpty
//               ? Positioned(
//                   left: 5,
//                   top: 30,
//                   child: SizedBox(
//                     width: AppSize.screenWidth / 2.5,
//                     height: AppSize.screenWidth / 2.5,
//                     child: isCameraUse == false
//                         ? Container(
//                             color: AppColors.primaryGrey,
//                             child: Center(
//                                 child: Container(
//                                     height: AppSize.screenWidth / 4.5,
//                                     width: AppSize.screenWidth / 4.5,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: AppColors.blueLight,
//                                             width: 5),
//                                         color: AppColors.blueLight
//                                             .withOpacity(0.7),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(1000))),
//                                     child: Center(
//                                         child: CustomText(
//                                             text: widget.firstName![0] +
//                                                 widget.lastName![0],
//                                             fontSize: AppSize.screenWidth / 10,
//                                             fontWeight: FontWeight.bold,
//                                             fontColor:
//                                                 AppColors.primaryGrey)))))
//                         : AgoraVideoView(
//                             controller: VideoViewController(
//                               rtcEngine: engine,
//                               canvas: const VideoCanvas(
//                                 uid: 0,
//                               ),
//                               useFlutterTexture: isUseFlutterTexture,
//                               useAndroidSurfaceView: isUseAndroidSurfaceView,
//                             ),
//                           ),
//                   ),
//                 )
//               : const SizedBox.shrink(),
//           Align(
//               alignment: Alignment.bottomCenter,
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                         child: InkWell(
//                             splashColor: widget.templateColor,
//                             onTap: () {
//                               if (isMicUse == true) {
//                                 setState(() {
//                                   isMicUse = false;
//                                   micIcon = AppAssets.micOff;
//                                   micDisable();
//                                 });
//                               } else {
//                                 setState(() {
//                                   isMicUse = true;
//                                   micIcon = AppAssets.micOn;
//                                   micEnable();
//                                 });
//                               }
//                             },
//                             child: Image.asset(
//                               micIcon,
//                               scale: AppSize.isTablet() == true ? 2 : 3.5,
//                             ))),
//                     Expanded(
//                         child: InkWell(
//                             splashColor: widget.templateColor,
//                             onTap: () {
//                               if (isCameraUse == true) {
//                                 setState(() {
//                                   isCameraUse = false;
//                                   cameraIcon = AppAssets.videoOff;
//                                   videoDisable();
//                                 });
//                               } else {
//                                 setState(() {
//                                   isCameraUse = true;
//                                   cameraIcon = AppAssets.videoOn;
//                                   videoEnable();
//                                 });
//                               }
//                             },
//                             child: Image.asset(
//                               cameraIcon,
//                               scale: AppSize.isTablet() == true ? 2 : 3.5,
//                             ))),
//                     Expanded(
//                       child: InkWell(
//                           splashColor: widget.templateColor,
//                           onTap: () {
//                             if (isLightUse == true) {
//                               setState(() {
//                                 isLightUse = false;
//                                 lightIcon = AppAssets.lightOff;
//                                 lightDisable();
//                               });
//                             } else {
//                               setState(() {
//                                 isLightUse = true;
//                                 lightIcon = AppAssets.lightOn;
//                                 lightEnable();
//                               });
//                             }
//                           },
//                           child: Image.asset(
//                             lightIcon,
//                             scale: AppSize.isTablet() == true ? 2 : 3.5,
//                           )),
//                     ),
//                     Expanded(
//                         child: InkWell(
//                             splashColor: widget.templateColor,
//                             onTap: () {
//                               if (isFlipCamera == true) {
//                                 setState(() {
//                                   isFlipCamera = false;
//                                   flipIcon = AppAssets.flipFront;
//                                 });
//                               } else {
//                                 setState(() {
//                                   isFlipCamera = true;
//                                   flipIcon = AppAssets.flipBack;
//                                 });
//                               }
//                               switchCamera();
//                             },
//                             child: Image.asset(
//                               flipIcon,
//                               scale: AppSize.isTablet() == true ? 2 : 3.5,
//                             ))),
//                     Expanded(
//                         child: InkWell(
//                             splashColor: AppColors.primaryBlack,
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: ((ctx) => PlaceholderDialog(
//                                         icon: Icon(
//                                           Icons.warning_amber,
//                                           size: AppSize.iconSize * 2,
//                                           color: Colors.red,
//                                         ),
//                                         title:
//                                             "Do you really want to leave call?",
//                                         actions: [
//                                           QuickSelectButton(
//                                             ontap: () {
//                                               Navigator.pop(context);
//                                             },
//                                             btncolor: AppColors.blueColor,
//                                             text: "Cancel",
//                                           ),
//                                           QuickSelectButton(
//                                               ontap: () {
//                                                 if (isJoined) {
//                                                   disposeRtcEngine();

//                                                   //   Navigator.of(context).pushAndRemoveUntil(
//                                                   //       MaterialPageRoute(
//                                                   //           builder:
//                                                   //               (context) =>
//                                                   //                   const IconsCircle()),
//                                                   //       (Route<dynamic>
//                                                   //               route) =>
//                                                   //           false);
//                                                   Navigator.pop(context);
//                                                 }
//                                               },
//                                               btncolor: AppColors.blueColor,
//                                               text: "Confirm"),
//                                         ],
//                                       )));
//                             },
//                             child: Image.asset(
//                               callIcon,
//                               scale: AppSize.isTablet() == true ? 2 : 3.5,
//                             )))
//                   ])),
//         ])));
//   }

//   Future<void> initRtcEngine() async {
//     await [Permission.microphone, Permission.camera].request();
//     setState(() {
//       loader = true;
//     });
//     engine = createAgoraRtcEngine();
//     await engine.initialize(RtcEngineContext(
//       appId: appId,
//     ));

//     engine.registerEventHandler(RtcEngineEventHandler(
//       onError: (ErrorCodeType err, String msg) {
//         print('[onError] err: $err, msg: $msg');
//       },
//       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         print(
//             ' [onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
//         setState(() {
//           isJoined = true;
//         });
//       },
//       onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
//         print(
//             '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
//         setState(() {
//           remoteUid.add(rUid);
//           if (remoteUid.isNotEmpty) {
//             Future.delayed(const Duration(minutes: 20), () {
//               disposeRtcEngine();

//               // Navigator.of(context).pushAndRemoveUntil(
//               //     MaterialPageRoute(builder: (context) => const IconsCircle()),
//               //     (Route<dynamic> route) => false);
//               Navigator.pop(context);
//             });
//           }
//         });
//       },
//       onUserMuteVideo: (connection, remoteUid, muted) {
//         setState(() {
//           RemoteUserid = remoteUid.toString();
//           isRemoteUserMuted = muted;
//         });
//       },
//       onUserOffline:
//           (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
//         print(
//             '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
//         setState(() {
//           remoteUid.removeWhere((element) => element == rUid);
//           if (widget.userType == "candidate") {
//             disposeRtcEngine();

//             // Navigator.of(context).pushAndRemoveUntil(
//             //     MaterialPageRoute(builder: (context) => const IconsCircle()),
//             //     (Route<dynamic> route) => false);
//             Navigator.pop(context);
//           }
//         });
//       },
//       onLeaveChannel: (RtcConnection connection, RtcStats stats) {
//         print(
//             '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
//         setState(() {
//           isJoined = false;
//           remoteUid.clear();
//         });
//       },
//     ));
//     await engine.enableVideo();

//     await engine.setVideoEncoderConfiguration(
//       const VideoEncoderConfiguration(
//         dimensions: VideoDimensions(width: 1280, height: 720),
//         frameRate: 30,
//         bitrate: 2000,
//       ),
//     );

//     await engine.startPreview();

//     setState(() {
//       isReadyPreview = true;
//       loader = true;
//       joinChannel();
//     });
//   }

//   Future<void> initConfig() async {
//     // Future.delayed(const Duration(seconds: 1), () {
//     if (widget.isAudioOnly == true) {
//       setState(() {
//         isCameraUse = false;
//         cameraIcon = AppAssets.videoOff;
//       });
//       videoDisable();
//     } else {
//       if (widget.isAudioMuted == true) {
//         setState(() {
//           isMicUse = false;
//           micIcon = AppAssets.micOff;
//         });
//         micDisable();
//       }
//       if (widget.isVideoMuted == true) {
//         setState(() {
//           isCameraUse = false;
//           cameraIcon = AppAssets.videoOff;
//         });
//         videoDisable();
//       }
//     }

//     print(widget.isAudioOnly);
//     print(widget.isAudioMuted);
//     print(widget.isVideoMuted);
//     // });
//   }

//   Future<void> joinChannel() async {
//     print("~~~~~~~~~~~~~~~~~~~~~~JOIN CHANNEL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
//     print("Channel Id:" + widget.channelId!);
//     print("Channel profile type:" + channelProfileType.name);
//     print("Channel role type:" + ClientRoleType.clientRoleBroadcaster.name);
//     print("~~~~~~~~~~~~~~~~~~~~~~JOIN CHANNEL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
//     await engine.joinChannel(
//       token: "",
//       channelId: widget.channelId!,
//       uid: 0,
//       options: ChannelMediaOptions(
//           channelProfile: channelProfileType,
//           clientRoleType: ClientRoleType.clientRoleBroadcaster),
//     );

//     initConfig();
//   }

//   Future<void> switchCamera() async {
//     await engine.switchCamera();
//   }

//   Future<void> micDisable() async {
//     await engine.muteLocalAudioStream(true);
//   }

//   Future<void> micEnable() async {
//     await engine.muteLocalAudioStream(false);
//   }

//   Future<void> lightDisable() async {
//     await engine.setCameraTorchOn(false);
//   }

//   Future<void> lightEnable() async {
//     await engine.setCameraTorchOn(true);
//   }

//   Future<void> videoDisable() async {
//     await engine.muteLocalVideoStream(true);
//   }

//   Future<void> videoEnable() async {
//     await engine.muteLocalVideoStream(false);
//   }

//   Future<void> focusEnable() async {
//     await engine.setCameraAutoFocusFaceModeEnabled(true);
//   }

//   Future<void> focusDisable() async {
//     await engine.setCameraAutoFocusFaceModeEnabled(false);
//   }

//   Future<void> leaveChannel() async {
//     await engine.leaveChannel();
//   }

//   Future<void> releaseChannel() async {
//     await engine.release();
//   }

//   Future<void> disposeRtcEngine() async {
//     leaveChannel();
//     releaseChannel();
//   }
// }
