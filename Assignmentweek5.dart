import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AssignmentWeek5 extends StatefulWidget {
  const AssignmentWeek5({super.key});

  @override
  State<AssignmentWeek5> createState() => _AssignmentWeek5State();
}

class _AssignmentWeek5State extends State<AssignmentWeek5> {
  List<Product> products = [];
  final String baseUrl = "http://127.0.0.1:8001"; // ✅ ใช้แทน localhost

  // โหลดข้อมูลจาก API
  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/products'));
      print("📥 Fetch status: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          products = jsonList.map((e) => Product.fromJson(e)).toList();
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("❌ Fetch error: $e");
    }
  }

  // เพิ่มสินค้า
  Future<void> createProduct(Map<String, dynamic> data) async {
    try {
      print("📦 Creating product: $data");
      var response = await http.post(
        Uri.parse("$baseUrl/products"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      print("📩 Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('เพิ่มสินค้าสำเร็จ!'),
            backgroundColor: Colors.green,
          ),
        );
        fetchData();
      } else {
        throw Exception("Failed to create product");
      }
    } catch (e) {
      print("❌ Create error: $e");
    }
  }

  // แก้ไขสินค้า
  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    try {
      print("🛠 Updating product $id with $data");
      var response = await http.put(
        Uri.parse("$baseUrl/products/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      print("📩 Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('แก้ไขสินค้าสำเร็จ!'),
            backgroundColor: Colors.blue,
          ),
        );
        fetchData();
      } else {
        throw Exception("Failed to update product");
      }
    } catch (e) {
      print("❌ Update error: $e");
    }
  }

  // ลบสินค้า
  Future<void> deleteProduct(String id) async {
    try {
      print("🗑 Deleting product $id");
      var response = await http.delete(Uri.parse("$baseUrl/products/$id"));
      print("📩 Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ลบสินค้าสำเร็จ!'),
            backgroundColor: Colors.red,
          ),
        );
        fetchData();
      } else {
        throw Exception("Failed to delete product");
      }
    } catch (e) {
      print("❌ Delete error: $e");
    }
  }

  // ฟอร์มสร้าง/แก้ไขสินค้า
  void showProductForm({Product? product}) {
    final nameCtrl = TextEditingController(text: product?.name ?? "");
    final descCtrl = TextEditingController(text: product?.description ?? "");
    final priceCtrl = TextEditingController(
      text: product?.price.toString() ?? "",
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product == null ? "เพิ่มสินค้า" : "แก้ไขสินค้า"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "ชื่อสินค้า"),
              ),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: "รายละเอียด"),
              ),
              TextField(
                controller: priceCtrl,
                decoration: const InputDecoration(labelText: "ราคา"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("ยกเลิก"),
          ),
          ElevatedButton(
            onPressed: () {
              final data = {
                "name": nameCtrl.text,
                "description": descCtrl.text,
                "price": double.tryParse(priceCtrl.text) ?? 0,
              };
              if (product == null) {
                createProduct(data);
              } else {
                updateProduct(product.id, data);
              }
              Navigator.pop(ctx);
            },
            child: const Text("บันทึก"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 72, 20),
        title: const Text('Product', style: TextStyle(color: Colors.white)),
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: products.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.grey),
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(1)} ฿',
                        style: const TextStyle(color: Colors.green),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => showProductForm(product: product),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("ยืนยันการลบ"),
                              content: Text("คุณต้องการลบ ${product.name}?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text("ยกเลิก"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    deleteProduct(product.id);
                                  },
                                  child: const Text("ลบ"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showProductForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ===== Model Class =====
class Product {
  final String id;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0,
    );
  }
}
