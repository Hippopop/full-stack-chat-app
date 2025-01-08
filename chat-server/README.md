# Full-Stack Chat App (Backend)

This project is a full-stack chat application with a Node.js backend and a Flutter frontend. This repository contains the backend part of the application. It's one of my hobby projects that I'm casually working on in my spare time.

## Overview

The Full-Stack Chat App is designed to provide real-time messaging capabilities with a robust and scalable backend architecture. It utilizes modern technologies and best practices to ensure efficient communication and data management.

## Technologies Used

- Node.js + Express.js
- Socket.IO for real-time communication
- Drizzle ORM for database operations
- MySQL as the database
- TypeScript for type-safe development
- JWT for authentication
- Bcrypt for password hashing

## Key Features

- User authentication and authorization
- User to user connection management
- Real-time messaging (*on-progress)

## Project Structure

The backend is organized into several key components:

- `src/`
  - `drizzle_mysql/`: Database schemas and configurations
  - `repositories/`: Data access layer for database operations
  - `socket_io/`: Socket.IO event handlers and middleware
  - `routes/`: API routes (if applicable)
  - `utils/`: Utility functions and helpers

## Future Plans

Here's a roadmap for future enhancements to the backend:

1. [ ] Keep restructuring the database to scale better.
   - [ ] Add the feature to send typing indicator. (*Not sure if I need that in a database level)
2. [ ] Add redis for caching mechanism.
3. [ ] Use redis pub/sub for real-time messaging and updates.
4. [ ] Use drizzle's one-time sql generation to optimize performance.
5. [ ] Integrate push notifications
6. [ ] Implement end-to-end encryption for messages and authentication!
7. [ ] And sooo many mooreee...! 😵‍💫

## Contributing

This project is open for contributions. If you're interested in helping out or have any suggestions, feel free to open an issue or submit a pull request.

