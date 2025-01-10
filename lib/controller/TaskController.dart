import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../model/task.dart';

class TaskController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<Task> tasks = <Task>[].obs;
  RxList<Task> filteredTasks = <Task>[].obs;
  RxList<Task> get pendingTasks => tasks.where((task) => task.status == 'Pending').toList().obs;
  RxList<Task> get inProgressTasks => tasks.where((task) => task.status == 'In Progress').toList().obs;
  RxList<Task> get completedTasks => tasks.where((task) => task.status == 'Completed').toList().obs;

  Database? _db;

  @override
  void onInit() {
    super.onInit();
    _initializeDb();
    _loadTasksFromDb();
    addTask(Task(
      id: '1',
      title: 'Task 1',
      description: 'Description 1',
      status: 'Pending',
      dueDate: DateTime.now(),
      priority: 'High',
    ));

    addTask(Task(
      id: '2',
      title: 'Task 2',
      description: 'Description 2',
      status: 'In Progress',
      dueDate:  DateTime.now(),
      priority: 'Medium',
    ));

    addTask(Task(
      id: '3',
      title: 'Task 3',
      description: 'Description 3',
      status: 'Completed',
      dueDate:  DateTime.now(),
      priority: 'Low',
    ));
  }

  Future<void> _initializeDb() async {
    _db = await openDatabase('tasks.db', version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(id TEXT PRIMARY KEY, title TEXT, description TEXT, dueDate TEXT, priority TEXT, status TEXT)',
      );
    });
  }
  void updateTask( Task updatedTask,int index) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = updatedTask;
      tasks.refresh();
    } else {
      print("Task not found at index: $index");
    }
  }
  Future<void> _loadTasksFromDb() async {
    final List<Map<String, dynamic>> maps = await _db!.query('tasks');
    tasks.value = maps.map((map) => Task.fromMap(map['id'], map)).toList();
  }

  Future<void> syncTasksWithFirestore() async {
    final QuerySnapshot snapshot = await _firestore.collection('tasks').get();
    List<Task> taskList = snapshot.docs.map((doc) {
      return Task.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();

    for (var task in taskList) {
      await _db!.insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    tasks.value = taskList;
  }

  Future<void> addTask(Task task) async {
    DocumentReference docRef = await _firestore.collection('tasks').add(task.toMap());
    task.id = docRef.id;

    await _db!.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    tasks.add(task);
  }

  Future<void> editTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toMap());

    await _db!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );

    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();

    await _db!.delete('tasks', where: 'id = ?', whereArgs: [taskId]);

    tasks.removeWhere((task) => task.id == taskId);
  }

  void filterTasksByStatus(String status) {
    filteredTasks.value = tasks.where((task) => task.status == status).toList();
  }

  void sortTasksByDueDate() {
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  Future<void> syncUnsyncedTasks() async {

  }
}
