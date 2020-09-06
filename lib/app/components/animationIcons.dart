// import 'dart:async';

// import 'package:flutter/material.dart';

// class HighLightedIcon extends StatefulWidget {
//   final IconData icon;
//   final double size;
//   final Color color;

//   HighLightedIcon(
//     this.icon, {
//     Key key,
//     this.size = 24.0,
//     this.color,
//   })
//       : super(key: key);
//   @override
//   State<HighLightedIcon> createState() {
//     return new _AnimatedIconState();
//   }
// }

// class _AnimatedIconState extends State<HighLightedIcon>
//     with SingleTickerProviderStateMixin {
//   final double dx = 10.0;
//   AnimationController controller;
//   Animation<double> animation;

//   @override
//   initState() {
//     super.initState();
//     controller = new AnimationController(
//         duration: const Duration(milliseconds: 500), vsync: this);
//     animation = new Tween(begin: widget.size, end: widget.size + dx)
//         .animate(controller);

//     animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         controller.reverse();
//       } else if (status == AnimationStatus.dismissed) {
//         new Future.delayed(const Duration(seconds: 10), () {
//           if (!mounted) return;
//           controller?.forward();
//         });
//       }
//     });
//     controller.forward();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new _Animator(
//       icon: widget.icon,
//       animation: animation,
//       color: widget.color,
//       size: widget.size + dx,
//     );
//   }
// }

// class _Animator extends AnimatedWidget {
//   final double size;
//   final IconData icon;
//   final Color color;
//   _Animator({
//     Key key,
//     this.icon,
//     this.size,
//     this.color,
//     Animation<double> animation,
//   })
//       : super(key: key, listenable: animation);

//   @override
//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable;
//     return new Container(
//       width: size,
//       height: size,
//       child: new Center(
//         child: new Icon(
//           icon,
//           size: animation.value,
//           color: color,
//         ),
//       ),
//     );
//   }
// }