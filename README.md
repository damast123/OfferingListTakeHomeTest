# Offering List

This repository contains the Offer List application, a full-stack project that includes both the frontend and backend components. The frontend is built using Flutter, and the backend is implemented with Node.js and MongoDB.

## Setup Instructions
1. Backend (Node.js)
Offering list requires [Node.js](https://nodejs.org/) v20+(lts) to run.
- Clone the repository:
```sh
git clone <repository-url>
cd <repository-folder>/backend
cd dillinger
npm i
node app
```
- Install the dependencies:
Ensure that the node has installed.
```sh
node -v
```
If it installed, then install the dependencies
```sh
npm i
```
- Set up environment variables:
Create a .env file in the backend root directory with the following content or use your own environment:
```sh
SERVER=localhost
DB_PORT=27017
DB_NAME=offerlistdb
SERVER_PORT=3300
```
- Start mongodb local or setup the mongodb atlas
- Start the backend server
```sh
npm start
```

2. Frontend (Flutter)
This project is a starting point for a Flutter application.
- Navigate to the frontend directory:
```sh
cd <repository-folder>/frontend/
```
- Install dependencies
Ensure you have Flutter installed:
```sh
flutter doctor
```
If it installed, then install the dependencies
```sh
flutter pub get
```
- Setting the configuration in lib/app/data/config/config.dart
Setting the url api according to the backend configuration.
- Run the Flutter app:
Connect a device or emulator, then run:
```sh
flutter run
```

## Architecture Explanation
1. Architecture Explanation
- Frontend: Flutter (UI Framework)
- Backend: Node.js (with Express framework)
- Database: MongoDB
- State Management: GetX (for state and dependency management in Flutter)

2. Component Interaction
- Flutter Frontend: Responsible for rendering the UI components and making HTTP requests to the backend API. GetX is used for managing state and reactive data.
- Express Backend: Exposes RESTful APIs for managing offers (CRUD operations). It communicates with MongoDB for data persistence.
- MongoDB: Stores offer data including title, description, and pricing details. Each offer has an auto-generated unique ID.

## Assumptions / Limitations
1. Assumptions
- The API endpoints are expected to follow REST conventions.
- MongoDB is used to persist data, and the application assumes that a valid MongoDB instance is running.
- The app will be connected to the local backend running on localhost:3300. To change this, the API URL in the frontend must be modified.
2. Limitations
- The current version does not handle user authentication. Future iterations could integrate a user system to associate offers with individual users.
- There is some unit testing is not work perfect because of the state management (getx).
- The frontend and backend are tightly coupled to local environments, and the app might not work properly when deployed to a production server without configuration adjustments.
- Error handling and input validation are basic and may need enhancements for production use.
- The app assumes that MongoDB is running locally on the default port, and might need adjustments for external MongoDB services.