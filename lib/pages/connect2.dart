import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekit_client/livekit_client.dart';

import 'room.dart';

class ConnectPage2 extends StatefulWidget {
  const ConnectPage2({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectPage2State();
}

class _ConnectPage2State extends State<ConnectPage2> {

  static const _storedKeyUri = '';
  static const _storedKeyToken = '';
  static const _storedKeySimulcast = '';

  bool _simulcast = true;
  bool _busy = false;

  

  @override
  void dispose(){
    super.dispose();
  }

  Future<void> _connect(BuildContext context) async {
    try {
      setState(() {
        _busy = true;
      });

      final room = await LiveKitClient.connect(
        _storedKeyUri,
        _storedKeyToken,
        roomOptions: RoomOptions(
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: _simulcast,
          ),
        ), 
      );

      await Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (_)=> RoomPage(room)),
      );
    } catch (error) {
      print ('Cannot connect $error');
      
    } finally {
      setState(() {
        _busy = false;
      });
    }
  }
  void _setSimulcast(bool? value) async {
    if (value == null || _simulcast == value) return;
    setState(() {
      _simulcast = value;
    });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    
  )

}
}
