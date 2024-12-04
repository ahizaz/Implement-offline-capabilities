import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/database_helper.dart';
import '../models/item.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs; // Reactive list of items
  var isLoading = true.obs; // Reactive loading indicator

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // Fetch data from the API
  Future<void> fetchData() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List jsonResponse = json.decode(response.body);
        final fetchedItems = jsonResponse.map((item) => Item(id: item['id'], name: item['title'])).toList();

        items.value = fetchedItems;
        await DatabaseHelper.instance.insertItems(fetchedItems); // Cache data locally
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Load cached data when API call fails
      items.value = await DatabaseHelper.instance.getItems();
    } finally {
      isLoading(false);
    }
  }
}