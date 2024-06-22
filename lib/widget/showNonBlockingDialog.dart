import 'package:flutter/material.dart';

void showNonBlockingDialog(BuildContext context, String text) {
  final overlayState = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5, // Adjust width here
            height: 110, // Adjust height here
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(214, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.tips_and_updates,
                  size: 28,
                  color: Color.fromARGB(255, 247, 225, 24),
                ),
                SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, shadows: [
                    Shadow(
                      color: Colors.white,
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    )
                  ]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
