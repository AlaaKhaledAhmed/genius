import 'package:flutter/material.dart';


class AppRoutes {
//pushTo========================================================================
  static void pushTo(BuildContext context, pageName,
      {bool? noAnimation,
      Duration transitionDuration = const Duration(milliseconds: 300)}) {
    noAnimation != null && noAnimation
        ? Navigator.push(context, MaterialPageRoute(builder: (_) => pageName))
        : Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: transitionDuration,
                // reverseTransitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    pageName,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  var curve = Curves.linear;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }));
  }

//pushReplacement========================================================================
  static void pushReplacementTo(BuildContext context, pageName,
      {bool? noAnimation}) {
    noAnimation != null && noAnimation
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => pageName))
        : Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                // transitionDuration: const Duration(seconds: 1),
                // reverseTransitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    pageName,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  var curve = Curves.linear;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }));
  }

//push And Remove All Page ========================================================================
  static pushAndRemoveAllPageTo(BuildContext context, page,
      {bool? noAnimation, required bool removeProviderData}) {
    if (removeProviderData == true) {
      // context.read<ProviderClass>().emptyProviderData();
      print('dddddddddddddeleat');
    }
    noAnimation != null && noAnimation
        ? Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => page), (route) => route.isFirst)
        : Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
                // transitionDuration: const Duration(seconds: 1),
                // reverseTransitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) => page,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  var curve = Curves.linear;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }),
            (route) => route.isFirst);
  }

  //push and refresh ===================================================================================
  static pushThenRefresh(context, pageName, {then}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageName,
        )).then(then);
  }
}
