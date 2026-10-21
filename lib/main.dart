import 'package:flutter/material.dart';

void main() {
  runApp(const SkladApp());
}

/// Корневой виджет приложения.
/// Задаёт общую тему (цвета, шрифты) для всего приложения.
class SkladApp extends StatelessWidget {
  const SkladApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Склад',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
      home: const SkladHomePage(),
    );
  }
}

/// Главный (и единственный) экран приложения.
/// Используется StatefulWidget, так как список товаров
/// будет меняться во время работы приложения.
class SkladHomePage extends StatefulWidget {
  const SkladHomePage({super.key});

  @override
  State<SkladHomePage> createState() => _SkladHomePageState();
}

class _SkladHomePageState extends State<SkladHomePage> {
  // Исходный список товаров — задаётся прямо в программе (ЛР1).
  final List<String> _tovary = [
    'Iphone 20 pro max',
    'Msi G100 RTX 6090',
    'javaScript для чабанов',
  ];

  // Контроллер для поля ввода названия нового товара (ЛР2).
  final TextEditingController _controller = TextEditingController();

  // Сообщение об ошибке, если поле пустое (доп. задание).
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Добавляет новый товар в список.
  /// Проверяет, что поле не пустое (доп. задание).
  void _dobavitTovar() {
    final String novoeNazvanie = _controller.text.trim();

    if (novoeNazvanie.isEmpty) {
      setState(() {
        _errorText = 'Введите название товара';
      });
      return;
    }

    setState(() {
      _tovary.add(novoeNazvanie);
      _controller.clear();
      _errorText = null;
    });
  }

  /// Удаляет товар из списка по индексу (доп. задание).
  void _udalitTovar(int index) {
    setState(() {
      _tovary.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой склад'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Блок добавления товара (ЛР2) ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Название товара',
                      errorText: _errorText,
                    ),
                    onSubmitted: (_) => _dobavitTovar(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _dobavitTovar,
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  child: const Text('Добавить'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- Счётчик товаров (доп. задание) ---
            Text(
              'Товаров на складе: ${_tovary.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 1),

            // --- Список товаров (ЛР1) ---
            Expanded(
              child: _tovary.isEmpty
                  ? const Center(
                      child: Text(
                        'Список товаров пуст',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tovary.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const Icon(
                              Icons.inventory_2,
                              color: Colors.indigo,
                            ),
                            title: Text(_tovary[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _udalitTovar(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}