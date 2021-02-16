import 'package:flutter/material.dart';

import './animate0.dart';
import './animate1.dart';
import './animate2.dart';
import './animate3.dart';
import './animate4.dart';
import './animate5.dart';

void main() {

  // #########################
  // animate0/LogoApp0 does no animation.
  // #########################
  // runApp(LogoApp0());

  // #########################
  // animate1.dart goes from 0 to full-size logo.
  // #########################
  // In animate1, we add a listener to the animation itself.
  // Every time the animation updates, we call a setState, so the screen
  // gets rebuilt with the updated values.

  // This is not efficient, as we're triggering state change in entire application.
  // runApp(LogoApp1());

  // #########################
  // animate2.dart goes from 0 to full-size logo
  // #########################
  // In animate2, we define the AnimatedLogo class to extend AnimatedWidget.
  
  // As such, we can compartmentalize the animation.
  // In fact, it doesn't require state at all anymore.
  // runApp(LogoApp2());

  // #########################
  // animate3.dart goes from 0 to full-size logo and back, cycling.
  // #########################
  // In animate3, we monitor the progress of the animation w/ addStatusListener().

  // In doing so, we utilize the four statuses of an animation:
  // (null), forward, completed, reverse, dismissed. 
  // runApp(LogoApp3());

  // #########################
  // animate4.dart goes from 0 to full-size logo
  // #########################
  // Refactor with AnimatedBuilder.

  // AnimatedBuilder means we no longer need statusListeners to trigger changes.
  // runApp(LogoApp4());

  // #########################
  // animate5.dart goes from 0 to full-size logo, simultaneously animating opacity.
  // #########################
  runApp(LogoApp5());

}
