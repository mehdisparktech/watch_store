# Message System Flow Diagram

## Visual Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         START (App Launch)                       │
└───────────────────────────────┬─────────────────────────────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │   Check User Role     │
                    │   (LocalStorage.role) │
                    └───────────┬───────────┘
                                │
                ┌───────────────┴───────────────┐
                │                               │
                ▼                               ▼
        ┌──────────────┐              ┌──────────────┐
        │  Role=Admin  │              │  Role=User   │
        └──────┬───────┘              └──────┬───────┘
               │                              │
               ▼                              ▼
    ┌──────────────────┐          ┌─────────────────────┐
    │  Direct to       │          │  Check MessageId    │
    │  Chat List       │          │  or UserId          │
    └──────┬───────────┘          └──────┬──────────────┘
           │                              │
           │                    ┌─────────┴─────────┐
           │                    │                   │
           │                    ▼                   ▼
           │          ┌──────────────────┐  ┌──────────────┐
           │          │  MessageId       │  │  No ID       │
           │          │  Exists?         │  │  Provided    │
           │          └────┬─────────────┘  └──────┬───────┘
           │               │                       │
           │               ▼                       │
           │     ┌──────────────────┐              │
           │     │  Direct Message  │              │
           │     │  Screen          │              │
           │     └──────────────────┘              │
           │                                       │
           └───────────────────┬───────────────────┘
                               │
                               ▼
                    ┌──────────────────┐
                    │   Chat List      │
                    │   Screen         │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  Select Chat     │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  Message Screen  │
                    └──────────────────┘
```

## Server-Side Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         SERVER START                             │
└───────────────────────────────┬─────────────────────────────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │   Receive User ID     │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │  API Call: GET /chats │
                    │  Returns chat list    │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │  Select Message ID    │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌──────────────────────────┐
                    │  API Call: GET /messages │
                    │  /:messageId             │
                    │  Returns all messages    │
                    └───────────┬──────────────┘
                                │
                                ▼
                    ┌──────────────────────────┐
                    │  Display Message Screen  │
                    │  (Two-person chat)       │
                    └───────────┬──────────────┘
                                │
                                ▼
                    ┌──────────────────────────┐
                    │         STOP             │
                    └──────────────────────────┘
```

## Decision Tree

```
User Opens Message System
│
├─ Is Admin?
│  ├─ YES → Show Chat List → Select Chat → Message Screen
│  └─ NO → Continue to User Flow
│
└─ Is User?
   ├─ Has MessageId?
   │  ├─ YES → Direct to Message Screen
   │  └─ NO → Continue
   │
   ├─ Has UserId?
   │  ├─ YES → Create Chat → Message Screen
   │  └─ NO → Show Chat List → Select Chat → Message Screen
```

## Component Interaction

```
┌──────────────────────────────────────────────────────────────────┐
│                     MessageRouterScreen                           │
│  (Entry Point - Handles Role-Based Routing)                      │
└────────────────┬─────────────────────────────────────────────────┘
                 │
     ┌───────────┴───────────┐
     │                       │
     ▼                       ▼
┌─────────────┐      ┌──────────────────┐
│ ChatList    │      │ MessageScreen    │
│ Screen      │      │                  │
└──────┬──────┘      └────────┬─────────┘
       │                      │
       ▼                      ▼
┌─────────────┐      ┌──────────────────┐
│ Chat        │      │ Message          │
│ Controller  │      │ Controller       │
└──────┬──────┘      └────────┬─────────┘
       │                      │
       └──────────┬───────────┘
                  │
                  ▼
         ┌────────────────┐
         │  API Service   │
         │  Socket Service│
         └────────────────┘
```

## State Management

```
LocalStorage
├─ role: "admin" | "user"
├─ userId: string
├─ myEmail: string
├─ myName: string
└─ myImage: string

ChatController
├─ chats: List<ChatModel>
├─ status: Status (loading/completed/error)
├─ page: int
└─ isAdmin: bool (computed)

MessageController
├─ messages: List<ChatMessageModel>
├─ chatId: string
├─ name: string
├─ peerImage: string
└─ status: Status
```

## API Endpoints

```
GET /chats?page=1
└─ Returns: { data: { chats: [...] } }

GET /messages/:chatId?page=1&limit=15
└─ Returns: { data: { messages: [...] } }

POST /create-chat
├─ Body: { participant: [userId] }
└─ Returns: { data: { _id: chatId } }

POST /messages/send-message/:chatId
├─ Body: { data: "{\"text\":\"message\"}" }
└─ Returns: { success: true }
```

## Socket Events

```
Client Listens:
├─ newMessage::${userId}
│  └─ Receives new messages for user
├─ message::${chatId}
│  └─ Receives messages for specific chat
└─ update-chatlist::${userId}
   └─ Receives chat list updates

Client Emits:
└─ (Messages sent via HTTP POST)
```

## Navigation Paths

```
1. Admin Flow:
   AppRoutes.messageRouter → ChatListScreen

2. User with MessageId:
   AppRoutes.messageRouter?messageId=xxx → MessageScreen

3. User with UserId:
   AppRoutes.messageRouter?userId=xxx → MessageScreen (create chat)

4. User without ID:
   AppRoutes.messageRouter → ChatListScreen

5. Direct Navigation:
   AppRoutes.chat → ChatListScreen
   AppRoutes.message?chatId=xxx → MessageScreen
```

## Error Handling

```
API Call Failed
├─ Show error snackbar
├─ Set status to Status.error
└─ Display ErrorScreen with retry option

Socket Disconnected
├─ Attempt reconnection
├─ Log connection status
└─ Continue with HTTP polling fallback

Invalid Parameters
├─ Log warning
├─ Fallback to chat list
└─ Show appropriate message to user
```

## Key Features

1. **Role-Based Access**
   - Admin: Full access to all chats
   - User: Access to own chats only

2. **Deep Linking Support**
   - Direct navigation to specific messages
   - Support for notification deep links

3. **Real-Time Updates**
   - Socket.IO integration
   - Automatic message synchronization

4. **Offline Support**
   - Local message caching
   - Queue messages for sending

5. **Pagination**
   - Load messages in chunks
   - Infinite scroll support

6. **Rich Media**
   - Text messages
   - Image messages
   - Emoji support
