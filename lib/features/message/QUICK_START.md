# Message System - Quick Start Guide

## তোমার Message System এ পরিবর্তন করা হয়েছে

### মূল পরিবর্তন (Main Changes)

আমি তোমার flow diagram অনুযায়ী message system টি implement করেছি যেখানে **2 টি role** আছে:
1. **Admin** - সব chat দেখতে পারে
2. **User** - নিজের chat দেখতে পারে

### কিভাবে কাজ করে (How It Works)

#### Admin এর জন্য:
```
Start → Role Check (Admin) → Direct Chat List
```

#### User এর জন্য:
```
Start → Role Check (User) → MessageId আছে?
  ├─ হ্যাঁ → Direct Message Screen
  └─ না → Chat List → Message Screen
```

## দ্রুত ব্যবহার (Quick Usage)

### 1. সবচেয়ে সহজ উপায় (Easiest Way)

```dart
// যেকোনো জায়গা থেকে message system খুলুন
Get.toNamed(AppRoutes.messageRouter);
```

এটি automatically:
- Admin হলে chat list দেখাবে
- User হলে messageId check করবে
- সঠিক screen এ নিয়ে যাবে

### 2. নির্দিষ্ট Message এ যেতে (Go to Specific Message)

```dart
Get.toNamed(
  AppRoutes.messageRouter,
  parameters: {
    "messageId": "chat_id_here",
    "name": "John Doe",
    "image": "profile.jpg",
  },
);
```

### 3. নতুন Chat শুরু করতে (Start New Chat)

```dart
Get.toNamed(
  AppRoutes.messageRouter,
  parameters: {
    "userId": "user_id_here",
    "name": "Jane Smith",
    "image": "profile.jpg",
  },
);
```

### 4. Helper Class ব্যবহার করে (Using Helper)

```dart
// Import করুন
import 'package:watch_store/features/message/presentation/widgets/message_navigation_helper.dart';

// ব্যবহার করুন
MessageNavigationHelper.navigateToMessagesRouter();

// বা নির্দিষ্ট message এ
MessageNavigationHelper.navigateToMessagesRouter(
  messageId: "chat_id",
  name: "User Name",
);

// বা product chat এর জন্য
MessageNavigationHelper.navigateToItemChat(
  userId: "seller_id",
  name: "Seller Name",
  itemName: "Omega Watch",
  itemPrice: "\$5,000",
);
```

## নতুন Files (New Files)

### 1. MessageRouterScreen
**Location**: `lib/features/message/presentation/screen/message_router_screen.dart`

এটি main entry point যা role check করে এবং সঠিক screen এ নিয়ে যায়।

### 2. MessageNavigationHelper
**Location**: `lib/features/message/presentation/widgets/message_navigation_helper.dart`

সহজে navigate করার জন্য helper methods।

### 3. Documentation Files
- `README.md` - সম্পূর্ণ documentation
- `FLOW_DIAGRAM.md` - Visual flow diagrams
- `IMPLEMENTATION_SUMMARY.md` - Implementation details
- `QUICK_START.md` - এই file

## পরীক্ষা করুন (Testing)

### Admin হিসেবে Test করতে:
```dart
LocalStorage.role = "admin";
Get.toNamed(AppRoutes.messageRouter);
// Result: Chat list দেখাবে
```

### User হিসেবে MessageId সহ:
```dart
LocalStorage.role = "user";
Get.toNamed(
  AppRoutes.messageRouter,
  parameters: {"messageId": "chat_123"},
);
// Result: Direct message screen
```

### User হিসেবে MessageId ছাড়া:
```dart
LocalStorage.role = "user";
Get.toNamed(AppRoutes.messageRouter);
// Result: Chat list দেখাবে
```

## পুরানো Code (Old Code)

তোমার পুরানো code এখনও কাজ করবে! কোন breaking change নেই।

```dart
// এগুলো এখনও কাজ করবে
Get.toNamed(AppRoutes.chat);
Get.toNamed(AppRoutes.message, parameters: {...});
```

## গুরুত্বপূর্ণ বিষয় (Important Notes)

1. **Role Setup**: নিশ্চিত করুন `LocalStorage.role` সঠিকভাবে set করা আছে
2. **Socket Connection**: Socket automatically connect হবে
3. **Real-time Updates**: Messages real-time এ আসবে
4. **Backward Compatible**: পুরানো navigation code কাজ করবে

## Example Code

### একটি Button থেকে Message খুলুন:

```dart
ElevatedButton(
  onPressed: () {
    MessageNavigationHelper.navigateToMessagesRouter();
  },
  child: Text('Open Messages'),
)
```

### Product থেকে Seller কে Message করুন:

```dart
ElevatedButton(
  onPressed: () {
    MessageNavigationHelper.navigateToItemChat(
      userId: product.sellerId,
      name: product.sellerName,
      image: product.sellerImage,
      itemImage: product.image,
      itemName: product.name,
      itemPrice: product.price,
    );
  },
  child: Text('Message Seller'),
)
```

### Notification থেকে Direct Message:

```dart
// Notification tap করলে
onNotificationTap: (messageId) {
  Get.toNamed(
    AppRoutes.messageRouter,
    parameters: {
      "messageId": messageId,
      "name": notificationData.senderName,
      "image": notificationData.senderImage,
    },
  );
}
```

## সাহায্য প্রয়োজন? (Need Help?)

1. **README.md** দেখুন - বিস্তারিত documentation
2. **FLOW_DIAGRAM.md** দেখুন - Visual flow বুঝতে
3. **message_usage_example.dart** দেখুন - Live examples
4. Logs check করুন - `appLog()` দিয়ে debug করুন

## সারাংশ (Summary)

✅ Role-based routing implemented (Admin/User)  
✅ Direct message access via messageId  
✅ Chat list for both roles  
✅ Real-time updates working  
✅ Backward compatible  
✅ Easy to use helper methods  
✅ Complete documentation  

তোমার message system এখন flow diagram অনুযায়ী কাজ করছে! 🎉
