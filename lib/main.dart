import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Planner',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[900],
        brightness: Brightness.dark,
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('kk'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return const Locale('kk');
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('kk');
      },
      home: HomePage(
        onThemeChanged: (mode) => setState(() => _themeMode = mode),
        onLocaleChanged: (locale) => setState(() => _locale = locale),
        currentThemeMode: _themeMode,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  final void Function(Locale) onLocaleChanged;
  final ThemeMode currentThemeMode;

  const HomePage({
    super.key,
    required this.onThemeChanged,
    required this.onLocaleChanged,
    required this.currentThemeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _tasks = List.generate(10, (index) => 'Task ${index + 1}');
  int _taskCounter = 11;

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Planner',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: isPortrait
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Tasks",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildTaskList()),
              ],
            )
                : Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Today's Tasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: _buildTaskList()),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _tasks.add('Task $_taskCounter');
            _taskCounter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Dismissible(
          key: Key(task),
          direction: DismissDirection.endToStart,
          background: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            color: Colors.redAccent,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) {
            setState(() {
              _tasks.removeAt(index);
            });
          },
          child: GestureDetector(
            onLongPress: () async {
              final newTask = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController controller = TextEditingController(text: _tasks[index]);
                  return AlertDialog(
                    title: Text('Edit Task'),
                    content: TextField(
                      controller: controller,
                      decoration: InputDecoration(hintText: 'Enter new task'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(controller.text); // Возвращаем новое значение
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              );
              if (newTask != null && newTask.isNotEmpty) {
                setState(() {
                  _tasks[index] = newTask; // Обновляем задачу с новым текстом
                });
              }
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.check_circle_outline,
                    color: Colors.indigo, size: 30),
                title: Text(
                  _tasks[index],
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: const Text('Tap to view details'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Settings'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Уменьшаем отступы
          content: SizedBox(
            width: 300, // Устанавливаем ширину диалогового окна
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Light Mode'),
                  leading: Radio<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: widget.currentThemeMode,
                    onChanged: (ThemeMode? mode) {
                      setState(() {
                        widget.onThemeChanged(mode!);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Dark Mode'),
                  leading: Radio<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: widget.currentThemeMode,
                    onChanged: (ThemeMode? mode) {
                      setState(() {
                        widget.onThemeChanged(mode!);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('English'),
                  onTap: () {
                    widget.onLocaleChanged(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Русский'),
                  onTap: () {
                    widget.onLocaleChanged(const Locale('ru'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Қазақша'),
                  onTap: () {
                    widget.onLocaleChanged(const Locale('kk'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
