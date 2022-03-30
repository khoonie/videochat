import 'package:videochat/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:videochat/swipe_cards/card_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  late User _user;
  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SwipeableCardSectionController _cardController =
        SwipeableCardSectionController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Swiper'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SwipeableCardsSection(
            context: context,
            cardController: _cardController,
            items: [
              CardView(text: 'First card'),
              CardView(text: 'Second card'),
              CardView(text: 'Third card'),
            ],
            onCardSwiped: (dir, index, widget) {},
            enableSwipeDown: true,
            enableSwipeUp: true,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.chevron_left),
                  onPressed: () => _cardController.triggerSwipeLeft(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.chevron_right),
                  onPressed: () => _cardController.triggerSwipeRight(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_upward),
                  onPressed: () => _cardController.triggerSwipeUp(),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_downward),
                  onPressed: () => _cardController.triggerSwipeDown(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
