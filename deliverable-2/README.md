# Green Peeps

## Description: 
*Provide a high-level description of your application and it's value from an end-user's perspective. What is the problem you're trying to solve? Is there any context required to understand why the application solves this problem?*

- Our application is supposed to track a user’s carbon emissions and provide personalized feedback. While other carbon emission tracking apps may compare a person’s carbon emissions to a global average, our app provides a breakdown of where the user’s carbon emissions are coming from as well. Furthermore, our app will recommend questions for the user to fill out and articles for them to read according to the preferences.

## Key Features: 

*Describe the key features in the application that the user can access. Provide a breakdown or detail for each feature that is most appropriate for your application. This section will be used to assess the value of the features built.*

- Database Implementation
- Users can create an account 
- Users can log into their account and see a personalized homescreen
- Users can fill out a questionnaire question whose value will be saved to their account (Note that this is saved to the database, but there is currently no feedback implemented so that users are able to see that data)
- Users can see a visualization pie chart for carbon emissions as a guest(currently we are using dummy values, but for the next deliverable users will be able to see their responses visualized. For now, this is only available for guests navigating the app.)
- The current features we have implemented for our application is the login page for regular users and guests, an initial questionnaire to get a basis of our user’s carbon emissions, and a visualization of their emissions (pie chart).

## Instructions:
*Clear instructions for how to use the application from the end-user's perspective. How do you access it? Are accounts pre-created or does a user register? Where do you start? etc. Provide clear steps for using each feature described above. This section is critical to testing your application and must be done carefully and thoughtfully*

- To start the mobile app, you should use an Android emulator where you are able to launch it with the apk file found in our GitHub repository.
- When you first start up the app, it takes you to a welcome page where it says “Welcome Traveller”. At this page is where you choose whether you are a new user, returning user or just want to navigate through the app.
  - Assume we are a new user. Then, we would choose to create a new account and we would put in our email, password, first name and last name. Once we click create an account, we would be taken to an initial questionnaire where you would answer some questions that determine your carbon emissions and all the initial statistics. According to you answer, a new question may or may not appear. If you answer "Yes" to "Do you own a car?", another question should appear. Otherwise, you will have completed all of the question in that branch and you can confirm your response, then save your responses to your account and quit. After this, it would take you to the homescreen.
  - Assume we are a returning user. Then, we would choose to login by typing our email and password. After this, it would take you to the homescreen.
  - Assume we just want to navigate through the app. Then it would just take us to the homescreen directly as a “Guest”.
  - A side note, when you create a new user, it gets stored in Firebase Authentication and a new user profile will get stored in Cloud Firestore. Also, when we want to login, it would fetch the information from Authentication and load up the details through Firestore. 
- When we get to the homescreen (currently no matter which option you choose above, you will be logged in as “Guest”), you will be able to see 4 boxes. 
  - Box 1: it just says “Welcome _insert_name_!”.
  - Box 2: it shows how many points you have and how many points you need to get to level up.
    - If you click this box, it will take you to a pop-up display where you can choose to answer more questions which will give you more points (currently this part of getting points, and the popup in general is not completely implemented, as responses are not currently being saved. This will be completed for devliverable 3).
  - Box 3: it shows the pie diagram with all your carbon emission statistics. 
    - If you click this box, a pop-up box will show up with more details on your emissions such as which category contributes the most and some ways to reduce. 
    - Note that you can only see the pie diagram if you are navigating the app as a guest. Users who have created an account and filled out the initial questionnaire do not yet have their carbon emissions visualized. 
  - Box 4: it shows a short fun fact of the day about the environment. 
    - If you click learn more, it would take you to an article about this fact (currently not implemented). 
- There are other pages you can go to right now such as goal screen, profile etc but they are not implemented yet and just empty. It will be done for deliverable 3. 

## Development Requirements:
*If a developer were to set this up on their machine or a remote server, what are the technical requirements (e.g. OS, libraries, etc.)? Briefly describe instructions for setting up and running the application (think a true README).*

- OS: Any (for Android setup) and MacOS or MacOS virtual machine (for iOS development)
- Libraries: Flutter
- Software: Android Studio (for IDE and/or Android Emulator), XCode (for iOS emulator, if on MacOS). 
- Recommended IDE: VSCode (Must install Dart and Flutter Extensions).

- INSTALLING FLUTTER:
  - https://flutter.dev/docs/get-started/install Choose your OS from the options in the link above and follow the instructions outlined up to and including the section Update your path to install Flutter on your system. 
  - For iOS platform setup on MacOS: https://flutter.dev/docs/get-started/install/macos#ios-setup 
  - For Android setup on MacOS: https://flutter.dev/docs/get-started/install/macos#android-setup 
  - For Android setup on Windows: https://flutter.dev/docs/get-started/install/windows#android-setup 
  - For Linux and Chrome OS, follow the instructions outlined in these links: 
    - https://flutter.dev/docs/get-started/install/chromeos 
    - https://flutter.dev/docs/get-started/install/linux 
- SETUP ANDROID EMULATOR:
  - If you do not have an emulator setup for Android, you can set one up easily by opening Android Studio, navigating to the Configure menu -> AVD Manager -> Create Virtual Device. 
  - Choose your device (Pixel 2 is confirmed to work with our app, although other emulators should work the same). 
  - Click Next, then download API 30 (or the latest Android System Image). 
  - Click Next and ensure that your Startup orientation is set to Portrait, Graphics is set to Automatic and Enable Device Frame is checked. 
  - Click Finish to begin installation. Once completed, move on to next steps in running the project.
- Once Flutter is installed on your system and an emulator is set up, open the code in your editor of choice (VSCode recommended). You may be prompted to “Install Missing Packages” which you should do. If you are using VSCode, be sure to install and enable the Flutter and Dart extensions.
- cd into the ‘green_peeps_app’ directory and run ‘flutter pub get’ in order to ensure that you have installed all the required dependencies in the pubspec.yaml file.
- In VSCode, ensure that you are running the app in the Android Emulator by changing the development environment in the bottom right corner of the IDE. To help find it, the button may say “No Device” or “Chrome (web-javascript)”. In the pop up that follows after clicking this button, choose the Android Emulator that you enabled previously or one that you may have already installed on your system. The emulator will launch automatically and may take a couple minutes to load.
- In the IDE, navigate to main.dart found in the lib folder (lib/main.dart). Click the run button or run ‘flutter run’ in the terminal. The initial start up of the app may take a couple minutes. Once the app has loaded, you are free to test and explore!

## Deployment and Github Workflow:
*Describe your Git / GitHub workflow. Essentially, we want to understand how your team members shares a codebase, avoid conflicts and deploys the application. If applicable, specify any naming conventions or standards you decide to adopt. Describe your overall deployment process from writing code to viewing a live application. What deployment tool(s) are you using and how. Don't forget to briefly explain why you chose this workflow or particular aspects of it!*

- Shared codebase uploaded to github
- Branch protection: main branch is protected
  - Pull requests are required on merges
  - One reviewer must approve merges prior to changes on main
  - Unit tests will be expected to pass on branches prior to merges
- Coding standards:
  - Effective Dart style guide:
  - https://dart.dev/guides/language/effective-dart/style 
- BDD for Development tool - basing the features over user stories
- Github actions for CI
- Team members are expected to test their own code
## Licenses:
*Keep this section as brief as possible. You may read this Github article for a start. What type of license will you apply to your codebase? What effect does it have on the development and use of your codebase? Why did you or your partner make this choice?* 

- We will apply the MIT open source license to our codebase. In deliverable 1, our partner and us agreed to number 3 of the licensing examples provided under the Intellectual Property Confidentiality Agreement section, which states “You will only share the code under an open-source license with the partner but agree to not distribute it in any way to any other entity or individual.”, with the addition that after project completion, we will be able to have the project code available as proof of our work for our resume and future job opportunities. This means that our code will have an open source license, but we will only distribute it to our partner and whoever our partner wants to distribute it to. Because of these conditions, we would need to be extra careful with not having any user data, API keys and other security concerns in the code, since it is open source and we don’t want user data leaks. But we would be watching out for that anyways, whether or not we put our code under an open source license. As for the use of our code, this would mean that once we distribute to our partner, he would be able to do whatever he wants with the code and share it with whoever he wants afterwards, as per the open source license. Our partner and us all gravitated towards the open source license option, as it would allow our partner to take the MVP code after we finish our project, and make changes to develop it into the app/business that he wants. It would also allow us to have agreed upon conditions to allow us to have the MVP code publicly available after project completion so that we can have proof of our work for resumes and future interviews/job opportunities.

**A deployed version of your application + a demo to your partner (include the link in your README.md)**
- Demo was performed live.
- https://drive.google.com/file/d/1RbtXX2JByrN_yiSGXeK7QJdqktg_aV-U/view?usp=sharing -- Link to generated APK
