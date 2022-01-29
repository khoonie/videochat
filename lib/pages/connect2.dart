import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekit_client/livekit_client.dart';
import '../exts.dart';
import '../theme.dart';
import 'room.dart';

//import 'room.dart';

class ConnectPage2 extends StatefulWidget {
  const ConnectPage2({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectPage2State();
}

class _ConnectPage2State extends State<ConnectPage2> {
  static const _storedKeyUri = 'wss://livekit.mumukiki.com';
  static const _storedKeyToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDU5NTM2OTQsImlzcyI6IkFQSUM2eG10M1NOcTlvQyIsImp0aSI6ImJpZ211bXUiLCJuYmYiOjE2NDMzNjE2OTQsInN1YiI6ImJpZ211bXUiLCJ2aWRlbyI6eyJyb29tIjoibXlyb29tIiwicm9vbUpvaW4iOnRydWV9fQ.n7u_qUs7C33yVcdUa4YTbxQPvCl0S2HIHnBcpWjDkAM';
  static const _storedKeySimulcast = '';

  bool _simulcast = true;
  bool _busy = false;

  @override
  void dispose() {
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
        MaterialPageRoute(builder: (_) => RoomPage(room)),
      );
    } catch (error) {
      print('Cannot connect $error');
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
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Simulcast'),
                              Switch(
                                value: _simulcast,
                                onChanged: (value) => _setSimulcast(value),
                                inactiveTrackColor:
                                    Colors.white.withOpacity(.2),
                                activeTrackColor: Colors.blue.shade50,
                                inactiveThumbColor:
                                    Colors.white.withOpacity(.5),
                                activeColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _busy ? null : () => _connect(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_busy)
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              const Text('CONNECT'),
                            ],
                          ),
                        ),
                      ],
                    )))),
      );
}
