# Flutter Web - HTTP API Connection Error Fix

## Problem
You're getting a `DioExceptionType.connectionError` when making API requests from Flutter Web to `http://62.72.26.31:5003/api/v1/users`.

This is caused by browser security policies that block:
1. **Mixed Content**: HTTPS web app → HTTP API
2. **CORS**: Cross-Origin Resource Sharing restrictions
3. **Insecure Private Network Requests**: Chrome's security feature

## Solutions

### ⚡ Quick Fix for Development

#### Option 1: Run with Chrome Flags (Recommended for Dev)

```bash
# Run Flutter web with disabled security (DEVELOPMENT ONLY)
flutter run -d chrome --web-browser-flag="--disable-web-security" --web-browser-flag="--disable-features=BlockInsecurePrivateNetworkRequests"
```

Or use VS Code launch configuration (already added in `.vscode/launch.json`):
- Press F5 or Run → Start Debugging
- Select "watch_store (Chrome - Disable Security)"

#### Option 2: Run on Mobile/Desktop Instead

Since this issue only affects web, test on mobile or desktop:

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# macOS
flutter run -d macos
```

### 🔧 Proper Fix for Production

#### 1. Backend CORS Configuration

Your backend server needs to add CORS headers. Add this to your Node.js/Express backend:

```javascript
// Add CORS middleware
const cors = require('cors');

app.use(cors({
  origin: ['http://localhost:*', 'https://yourdomain.com'], // Allow your web app
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true
}));
```

Or manually add headers:
```javascript
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  next();
});
```

#### 2. Use HTTPS for API (Best Practice)

Update your API endpoint to use HTTPS:

```dart
// lib/config/api/api_end_point.dart
class ApiEndPoint {
  // Change from HTTP to HTTPS
  static const baseUrl = "https://62.72.26.31:5003/api/v1/";  // Use HTTPS
  static const imageUrl = "https://62.72.26.31:5003";
  static const socketUrl = "https://62.72.26.31:5003";
  
  // ... rest of the code
}
```

**Note**: Your backend server must have SSL/TLS certificate configured.

#### 3. Environment-Based Configuration

Create different endpoints for web vs mobile:

```dart
// lib/config/api/api_end_point.dart
import 'package:flutter/foundation.dart';

class ApiEndPoint {
  // Use HTTPS for web, HTTP for mobile
  static String get baseUrl {
    if (kIsWeb) {
      return "https://62.72.26.31:5003/api/v1/";  // HTTPS for web
    } else {
      return "http://62.72.26.31:5003/api/v1/";   // HTTP for mobile
    }
  }
  
  static String get imageUrl {
    return kIsWeb ? "https://62.72.26.31:5003" : "http://62.72.26.31:5003";
  }
  
  static String get socketUrl {
    return kIsWeb ? "https://62.72.26.31:5003" : "http://62.72.26.31:5003";
  }
  
  // ... rest of the code
}
```

### 🧪 Testing the Fix

1. Stop your current Flutter web session
2. Run with the new configuration:
   ```bash
   flutter run -d chrome --web-browser-flag="--disable-web-security" --web-browser-flag="--disable-features=BlockInsecurePrivateNetworkRequests"
   ```
3. Try registering a user again
4. Check the console for successful API calls

### 📱 Alternative: Use Mobile/Desktop for Development

If you don't need to test on web, use mobile or desktop which don't have these restrictions:

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### ⚠️ Important Notes

1. **NEVER deploy to production with `--disable-web-security`** - it's only for development
2. The proper fix is to:
   - Configure CORS on your backend
   - Use HTTPS for production
3. Mobile/Desktop apps don't have these restrictions
4. Contact your backend team to enable CORS if you don't have backend access

### 🔍 Verify Backend is Running

Test if the API is accessible:

```bash
# Test from terminal
curl -X POST http://62.72.26.31:5003/api/v1/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"test123"}'
```

If this fails, the server might be down or unreachable from your network.

---

## Current Status

✅ Added VS Code launch configuration for development with disabled security
✅ Documented all solutions
⚠️ Need backend CORS configuration for production web deployment

