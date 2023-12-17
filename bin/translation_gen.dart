import 'dart:io';

import 'package:translation_gen/translation_gen.dart' as translation_gen;

List<String> values = [
  "Hello",
  "Male",
  "Female",
  "Other",
  "Gender",
  "Back",
  "Check",
  "Request",
  "Go back",
];

void main(List<String> arguments) async {
  final aiTranslatorApp = translation_gen.TranslatorApp();
  await aiTranslatorApp.start(
    sentences: values,
    translateToLanguage: 'German',
    appName: 'ganD',
  );
  exit(0);
}

// griot
// "Beloved One",
// "Error",
// "Story",
// "Loading",
// "Ignore",
// "Wrong",
// "Failure",
// "Account",
// "Logout",
// "Invite",
// "Day",
// "Month",
// "Save",
// "Year",
// "Male",
// "Female",
// "Other",
// "Gender",
// "Back",
// "Check",
// "Request",
// "Go back",
// "Connection Lost!",
// "Unnamed Memory",
// "Empty Memory",
// "Media Files",
// "to record?",
// "Check Later",
// "Create a memory",
// "Uploads Queue",
// "First Name",
// "Last Name",
// "Middle Name",
// "Request created",
// "All right!!!",
// "Griot Logo",
// "Requested a memory:",
// "An error occurred",
// "wants you to join",
// "requested a memory",
// "Request for Memory",
// "Create my frist Memory",
// "Your memory is saved.",
// "What memory do you want",
// "Here are a few ways to start?",
// "You're not suppose to be here",
// "Want to start adding Medias?",
// "Are you ready to start collecting your memories and sharing it with your beloved ones?",
// "Want to invite a Beloved one?",
// "Create my frist Memory",
// "Request a beloved for a Memory",
// "You have pending invitations!",
// "You have Memory Requests!",
// "An error occurred while loading the video",
// "Looks like you don't have any pending invitation",
// "Looks like you didn't save a Memory yet",
// "Looks like you don't have any pending request",
// "Why don't you preserve something you love",
// "Search someone",
// "you want to invite",
// "to your account",
// "We didn't find anyone :",
// "Do you want to adjust",
// "your search terms?",
