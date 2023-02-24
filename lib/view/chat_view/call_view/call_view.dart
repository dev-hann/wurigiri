import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class CallView extends StatefulWidget {
  const CallView({super.key});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  final room = Room();
  final roomOptions = const RoomOptions(
    adaptiveStream: true,
    dynacast: true,
  );
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    (() async {
      await room.localParticipant?.dispose();
      await room.disconnect();
      await room.dispose();
    });
    super.dispose();
  }

  void init() async {
    const token = "TestToken";
    const url = "wss://wurigiri-28llb3ms.livekit.cloud";

    await room.connect(url, token, roomOptions: roomOptions);
    // var localVideo = await LocalVideoTrack.createCameraTrack();
    try {
      // video will fail when running in ios simulator
      await room.localParticipant?.setCameraEnabled(true);
    } catch (error) {
      print('Could not publish video, error: $error');
    }

    await room.localParticipant?.setMicrophoneEnabled(true);
    // await room.localParticipant?.publishVideoTrack(localVideo);
  }

  AppBar appBar() {
    return AppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }
}
