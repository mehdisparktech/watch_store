# Message System Documentation

## Overview
This messaging system implements a role-based routing flow with two user types: **Admin** and **User**.

## Flow Diagram Implementation

### Server Side
- API Call: `GET /chats` - Returns all chat list
- API Call: `GET /messages/:messageId` - Returns messages for a specific chat
- Two-person chat with messageId

### App Side Flow

#### Start Point
The app checks two conditions:
1. **User Role** (admin or user)
2. **Message ID** (exists or not)

#### Admin Flow
```
Start → Role=Admin → Direct Chat List → Message Screen
```
- Admin users always see the chat list directly
- They can access all conversations

#### User Flow

##### Case 1: User with Message ID
```
Start → Role=User → MessageId exists → Direct Message Screen
```
- User goes directly to a specific conversation
- Useful for deep linking or notifications

##### Case 2: User without Message ID
```
Start → Role=User → No MessageId → Chat List → Message Screen
```
- User sees their chat list first
- They select a conversation to view messages

## Usage Examples

### 1. Navigate to Message Router (Recommended)
```dart
// For Admin - will show chat list
Get.toNamed(AppRoutes.messageRouter);

// For User with messageId - will show direct message
Get.toNamed(
  AppRoutes.messageRouter,
  parameters: {
    "messageId": "chat_id_here",
    "name": "John Doe",
    "image": "profile_image_url",
  },
);

// For User without messageId - will show chat list
Get.toNamed(AppRoutes.messageRouter);

// For User with userId (create new chat)
Get.toNamed(
  AppRoutes.messageRouter,
  parameters: {
    "userId": "user_id_here",
    "name": "Jane Smith",
    "image": "profile_image_url",
  },
);
```

### 2. Direct Navigation (Legacy Support)
```dart
// Direct to chat list
Get.toNamed(AppRoutes.chat);

// Direct to message screen
Get.toNamed(
  AppRoutes.message,
  parameters: {
    "chatId": "chat_id_here",
    "name": "John Doe",
    "image": "profile_image_url",
  },
  arguments: false, // isItemChat
);
```

## Role Configuration

The user role is stored in `LocalStorage.role` and can be:
- `"admin"` - Full access to all chats
- `"user"` - Access to own chats only

## API Endpoints

### Get Chat List
```
GET /chats?page=1
```
Returns list of all chats for the current user (or all chats for admin)

### Get Messages
```
GET /messages/:chatId?page=1&limit=15
```
Returns messages for a specific chat

### Create Chat
```
POST /create-chat
Body: { "participant": ["userId"] }
```
Creates a new chat with specified participant

### Send Message
```
POST /messages/send-message/:chatId
Body: { "data": "{\"text\":\"message text\"}" }
```
Sends a message to a specific chat

## Socket Events

### Listen for New Messages
```dart
// User-specific messages
SocketServices.on('newMessage::${LocalStorage.userId}', (data) {
  // Handle new message
});

// Chat-specific messages
SocketServices.on('message::$chatId', (data) {
  // Handle chat message
});
```

### Listen for Chat List Updates
```dart
SocketServices.on("update-chatlist::${LocalStorage.userId}", (data) {
  // Handle chat list update
});
```

## Key Components

### 1. MessageRouterScreen
- Entry point for message system
- Handles role-based routing logic
- Located at: `lib/features/message/presentation/screen/message_router_screen.dart`

### 2. ChatController
- Manages chat list
- Handles pagination
- Supports admin/user roles
- Located at: `lib/features/message/presentation/controller/chat_controller.dart`

### 3. MessageController
- Manages individual chat messages
- Handles real-time updates via sockets
- Supports message sending
- Located at: `lib/features/message/presentation/controller/message_controller.dart`

### 4. ChatListScreen
- Displays list of all chats
- Shows unread count
- Located at: `lib/features/message/presentation/screen/chat_screen.dart`

### 5. MessageScreen
- Displays messages in a chat
- Supports text and image messages
- Real-time message updates
- Located at: `lib/features/message/presentation/screen/message_screen.dart`

## Testing the Flow

### Test as Admin
1. Set `LocalStorage.role = "admin"`
2. Navigate to `AppRoutes.messageRouter`
3. Should see chat list directly

### Test as User with MessageId
1. Set `LocalStorage.role = "user"`
2. Navigate with messageId parameter
3. Should go directly to message screen

### Test as User without MessageId
1. Set `LocalStorage.role = "user"`
2. Navigate without messageId parameter
3. Should see chat list first

## Notes

- The system maintains backward compatibility with direct navigation
- Socket connections are automatically managed
- Messages are cached locally for better performance
- Supports both text and image messages
- Real-time updates via WebSocket
