import 'package:blue_eye_complete_project/drawer/contacts.dart';
import 'package:blue_eye_complete_project/drawer/dashboard.dart';
import 'package:blue_eye_complete_project/drawer/events.dart';
import 'package:blue_eye_complete_project/drawer/notes.dart';
import 'package:blue_eye_complete_project/drawer/notifications.dart';
import 'package:blue_eye_complete_project/drawer/privacy_policy.dart';
import 'package:blue_eye_complete_project/drawer/send_feedback.dart';
import 'package:blue_eye_complete_project/drawer/settings.dart';
import 'package:blue_eye_complete_project/pages/about.dart';
import 'package:blue_eye_complete_project/pages/chatbot.dart';
import 'package:blue_eye_complete_project/pages/emotion_detection_by_image.dart';
import 'package:blue_eye_complete_project/pages/emotion_detection_by_pose.dart';
import 'package:blue_eye_complete_project/pages/emotion_detection_by_voice.dart';
import 'package:blue_eye_complete_project/pages/homepage.dart';
import 'package:blue_eye_complete_project/pages/object_detection.dart';
import 'package:blue_eye_complete_project/utils/routes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const BlueEye());
}

class BlueEye extends StatelessWidget {
  const BlueEye({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.dashboardRoute: (context) => const DashboardPage(),
        MyRoutes.contactsRoute: (context) => const ContactsPage(),
        MyRoutes.eventsRoute: (context) => const EventsPage(),
        MyRoutes.notesRoute: (context) => const NotesPage(),
        MyRoutes.settingRoute: (context) => const SettingsPage(),
        MyRoutes.notificationsRoute: (context) => const NotificationsPage(),
        MyRoutes.privacyPolicyRoute: (context) => const PrivacyPolicyPage(),
        MyRoutes.sendFeedbackRoute: (context) => const SendFeedbackPage(),
        MyRoutes.objectDetectionRoute: (context) => const ObjectDetectionPage(),
        MyRoutes.emotionDetectionByObjectRoute: (context) =>
            const EmotionDetectionByObjectPage(),
        MyRoutes.emotionDetectionByPoseRoute: (context) =>
            const EmotionDetectionByPosePage(),
        MyRoutes.emotionDetectionByVoiceRoute: (context) =>
            const EmotionDetectionByVoicePage(),
        MyRoutes.chatbotRoute: (context) => const ChatbotPage(),
        MyRoutes.aboutRoute: (context) => const AboutPage(),
      },
    );
  }
}
