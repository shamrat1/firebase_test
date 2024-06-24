# Firebase Test Project
This project demonstrates Firebase firestore, cloud messaging and phone authentication system. A user can enter his phone number to login. An OTP code will be sent. Enter the OTP and authenticate. User will be redirected to home page. User will see a button to go to conversations page and another button to get an instant test notification. In conversation page, user will see all his recent conversations and can continue chat by just tapping on the conversation tile or he can press "New Message" button in the bottom right area of the screen. He'll be redirected to all users list where he can select any user to create a new chat or continue old chat. In the messages page, he'll see all his messages on right side and recipient's messages on left side. A tap on message bubble will show the message sent timestamp.

[Download APK](https://github.com/shamrat1/firebase_test/blob/main/apks/app-release.apk)
## Features

 - Password less login Feature with Firebase Phone Authentication system
 - Real-time chatting
 - Background and foreground Notifications with Adaptive dialog
 - Trigger notification within app (Cloud Messaging v2 api)
 - 
## Primary Packages Used

 - flutter_screenutil to implement pixel perfect ui from Figma or XD
 - google_fonts to use custom font
 - flutter_riverpod to manage state in the list of users
 - go_router
 
 ## Video
 <a href="https://ibb.co/SXVR9tW"><img src="https://i.ibb.co/6RDgfHV/Recording2024-06-24221059-ezgif-com-video-to-gif-converter.gif" width="250px" alt="Recording2024-06-24221059-ezgif-com-video-to-gif-converter" border="0"></a>
 ## Screenshots
 <a href="https://ibb.co/fpqq0RB"><img src="https://i.ibb.co/0MmmJN8/Screenshot-1719243637.png" alt="Screenshot-1719243637" border="0" width="200px"></a>
<a href="https://ibb.co/GCr8t9M"><img src="https://i.ibb.co/qm2cWCg/Screenshot-1719245297.png" alt="Screenshot-1719245297" border="0" width="200px"></a>
<a href="https://ibb.co/1dxSxWL"><img src="https://i.ibb.co/YyGrGs3/Screenshot-1719245301.png" alt="Screenshot-1719245301" border="0" width="200px"></a>
<a href="https://ibb.co/Vm0PhkK"><img src="https://i.ibb.co/8cnSRQh/Screenshot-1719245308.png" alt="Screenshot-1719245308" border="0" width="200px"></a>
<a href="https://ibb.co/8MdpGVm"><img src="https://i.ibb.co/Q9CRhGJ/Screenshot-1719245315.png" alt="Screenshot-1719245315" border="0" width="200px"></a>
<a href="https://ibb.co/rbL5kzJ"><img src="https://i.ibb.co/k3rqKwF/Screenshot-1719245320.png" alt="Screenshot-1719245320" border="0" width="200px"></a>
<a href="https://ibb.co/xSYQr3X"><img src="https://i.ibb.co/TB15NrY/Screenshot-1719245335.png" alt="Screenshot-1719245335" border="0" width="200px"></a>

## Installation

-   Ensure latest Flutter SDK and Git are installed.
-   Open Terminal/Command Prompt.
-   Navigate to your desired directory.
-   Run `git clone https://github.com/shamrat1/firebase_test.git` to clone the repository.
-   Navigate into the cloned repository using `cd`.
-   Run `flutter pub get` to fetch dependencies.
-   In [Cloud Messaging Service](https://github.com/shamrat1/firebase_test/blob/main/lib/utils/notification/cloud_messaging_service.dart), get your service account json file from firebase project settings and paste it in line 16 to 30. Otherwise push notifications will not work. 
-   Connect a device or start an emulator.
-   Ensure the device is recognized with `flutter devices`.
-   Run the project using `flutter run`.
