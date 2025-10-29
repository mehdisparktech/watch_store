# API Integration Guide - Watch Store App

এই guide এ দেখানো হয়েছে কিভাবে আপনার Flutter app এ API integration করবেন।

## 📁 Project Structure

```
lib/
├── features/
│   └── [feature_name]/
│       ├── data/
│       │   └── model/           # Data models
│       ├── repository/          # API calls
│       └── presentation/
│           ├── controller/      # GetX controllers
│           ├── screen/          # UI screens
│           └── widgets/         # Feature widgets
├── services/
│   └── api/
│       ├── api_service.dart     # HTTP client
│       └── api_response_model.dart
├── config/
│   └── api/
│       └── api_end_point.dart   # API endpoints
└── utils/
    └── helpers/
        └── other_helper.dart    # Helper functions
```

## 🚀 API Integration Steps

### Step 1: Create Data Model

```dart
// lib/features/products/data/model/product_model.dart
class ProductModel {
  final String? id;
  final String? name;
  final double? price;
  
  ProductModel({this.id, this.name, this.price});
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString(),
      price: json['price']?.toDouble(),
    );
  }
}
```

### Step 2: Create Repository

```dart
// lib/features/products/repository/product_repository.dart
class ProductRepository {
  static Future<ApiResponseModel> getAllProducts() async {
    return await ApiService.get("${ApiEndPoint.baseUrl}/products");
  }
  
  static Future<ApiResponseModel> getProductById(String id) async {
    return await ApiService.get("${ApiEndPoint.baseUrl}/products/$id");
  }
}
```

### Step 3: Create Controller

```dart
// lib/features/products/presentation/controller/product_controller.dart
class ProductController extends GetxController {
  final RxList<ProductModel> _products = <ProductModel>[].obs;
  final RxBool _isLoading = false.obs;
  
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading.value;
  
  Future<void> loadProducts() async {
    try {
      _isLoading.value = true;
      
      final response = await ProductRepository.getAllProducts();
      
      if (response.isSuccess) {
        final List<dynamic> productList = response.data['data'] ?? [];
        _products.value = productList
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        OtherHelper.showToast(response.message, Colors.red);
      }
    } catch (e) {
      OtherHelper.showToast('Failed to load products', Colors.red);
    } finally {
      _isLoading.value = false;
    }
  }
}
```

### Step 4: Create UI Screen

```dart
// lib/features/products/presentation/screen/product_list_screen.dart
class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());
    
    return Scaffold(
      appBar: CommonAppBar(title: "Products"),
      body: Obx(() {
        if (controller.isLoading) {
          return Center(child: CommonLoader());
        }
        
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return ListTile(
              title: Text(product.name ?? ''),
              subtitle: Text('\$${product.price}'),
            );
          },
        );
      }),
    );
  }
}
```

### Step 5: Add to Dependency Injection

```dart
// lib/config/dependency/dependency_injection.dart
Get.lazyPut(() => ProductController(), fenix: true);
```

### Step 6: Add Route

```dart
// lib/config/route/app_routes.dart
static const String products = "/product_list_screen.dart";

GetPage(name: products, page: () => const ProductListScreen()),
```

## 🔧 API Service Configuration

### Current API Service Features:
- ✅ GET, POST, PUT, PATCH, DELETE methods
- ✅ Multipart file upload
- ✅ Automatic token handling
- ✅ Error handling
- ✅ Request/Response logging
- ✅ Timeout configuration

### API Endpoints:
```dart
// lib/config/api/api_end_point.dart
class ApiEndPoint {
  static const baseUrl = "http://103.145.138.74:3000/api/v1";
  static const products = "products";
  static const categories = "categories";
  static const brands = "brands";
}
```

## 📱 Demo Usage

### Navigate to Demo Screen:
```dart
Get.toNamed(AppRoutes.demoApi);
```

### Test API Calls:
1. Load Products - সব products load করে
2. Search 'Rolex' - specific search করে
3. Filter Smart Watch - category filter করে
4. Clear Filters - সব filter clear করে

## 🎯 Key Features Implemented

### ✅ Complete API Integration
- Model, Repository, Controller pattern
- Error handling
- Loading states
- Success/failure feedback

### ✅ Advanced Features
- Pagination support
- Search functionality
- Category/Brand filtering
- Pull to refresh
- Infinite scrolling

### ✅ UI Components
- Loading indicators
- Error states
- Empty states
- Toast messages
- Responsive design

## 🔍 How to Test

1. **Demo Screen দেখুন:**
   ```dart
   Get.toNamed(AppRoutes.demoApi);
   ```

2. **Product List দেখুন:**
   ```dart
   Get.toNamed(AppRoutes.products);
   ```

3. **API calls test করুন:**
   - Load Products button click করুন
   - Search functionality test করুন
   - Filter options try করুন

## 📝 API Response Format

Expected API response format:
```json
{
  "success": true,
  "message": "Products fetched successfully",
  "data": [
    {
      "_id": "product_id",
      "name": "Product Name",
      "price": 299.99,
      "brand": "Brand Name",
      "category": "Category",
      "image": "/uploads/image.jpg",
      "isAvailable": true,
      "createdAt": "2024-01-01T00:00:00.000Z"
    }
  ],
  "totalPages": 5,
  "currentPage": 1,
  "totalItems": 50
}
```

## 🚨 Error Handling

API service automatically handles:
- Network errors
- Timeout errors
- Server errors (4xx, 5xx)
- JSON parsing errors

Error messages are shown via toast notifications.

## 🔐 Authentication

API service automatically adds Bearer token to requests:
```dart
options.headers["Authorization"] = "Bearer ${LocalStorage.token}";
```

## 📊 Logging

All API requests and responses are logged for debugging:
- Request URL, method, headers, body
- Response status, data
- Error details

Check console for detailed logs during development.