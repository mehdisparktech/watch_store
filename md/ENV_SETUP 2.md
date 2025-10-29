# Environment Setup

## .env File Configuration

Create a `.env` file in the root directory with the following variables:

```env
# API Configuration
API_BASE_URL=https://your-api-base-url.com/api/v1

# Socket Configuration  
SOCKET_URL=https://your-socket-url.com

# App Configuration
APP_NAME=Watch Store
APP_VERSION=1.0.0

# Debug Configuration
DEBUG_MODE=true
```

## Note

The `.env` file is gitignored for security reasons. Make sure to create it locally for your development environment.

If the `.env` file is missing, the app will still run with default configurations.
