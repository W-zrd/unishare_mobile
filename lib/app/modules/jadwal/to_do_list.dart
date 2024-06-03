import 'package:flutter/material.dart';
import 'package:unishare/app/controller/todo_controller.dart';
import 'package:unishare/app/models/todo.dart';
import 'package:unishare/app/modules/jadwal/add_to_do_page.dart';
import 'package:unishare/app/widgets/button/ternary_button.dart';
import 'package:unishare/app/widgets/card/to_do_list_card.dart';
import 'package:unishare/app/widgets/chart/chart.dart';
import 'package:unishare/app/widgets/chart/chart_explanation.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage({Key? key}) : super(key: key);

  final ToDoController _todoController = ToDoController();
  final double radiusValue = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 247, 255),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistik',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            StreamBuilder<List<ToDo>>(
              stream: _todoController.fetchToDos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var todos = snapshot.data!;
                double onTimeValue = 0;
                double lateValue = 0;
                double onGoingValue = 0;

                final now = DateTime.now();

                for (var todo in todos) {
                  final deadline = todo.deadline;

                  if (todo.status == 'completed') {
                    onTimeValue++;
                  } else if (todo.status == 'late') {
                    lateValue++;
                  } else {
                    if (deadline.isBefore(now)) {
                      lateValue++;
                    } else {
                      onGoingValue++;
                    }
                  }
                }

                double total = onTimeValue + lateValue + onGoingValue;
                if (total > 0) {
                  onTimeValue = (onTimeValue / total) * 100;
                  lateValue = (lateValue / total) * 100;
                  onGoingValue = (onGoingValue / total) * 100;
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: total == 0
                          ? BlueCirclePlaceholder(radiusValue: radiusValue)
                          : PieChartSample2(
                              onTimeValue: onTimeValue,
                              lateValue: lateValue,
                              onGoingValue: onGoingValue,
                              radiusValue: radiusValue,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChartExplanation(
                              text: total == 0
                                  ? 'Tidak ada data'
                                  : '$onTimeValue% selesai tepat waktu',
                              color: total == 0
                                  ? Colors.blue.withOpacity(0.3)
                                  : const Color.fromARGB(255, 34, 222, 154)),
                          total > 0
                              ? ChartExplanation(
                                  text: '$lateValue% lewat batas waktu',
                                  color: const Color.fromARGB(255, 222, 34, 57))
                              : Container(),
                          total > 0
                              ? ChartExplanation(
                                  text: '$onGoingValue% masih berlangsung',
                                  color: const Color.fromARGB(255, 217, 217, 217))
                              : Container(),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.5,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(73),
                            ),
                            child: TernaryButton(
                                onPressed: (){}, 
                                label: 'Lihat Detail', 
                                iconData: Icons.info_outline, 
                                width: 173),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Hari ini',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<ToDo>>(
                stream: _todoController.fetchToDos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var todos = snapshot.data!;
                  if (todos.isEmpty) {
                    return Center(child: Text("Tidak ada To Do"));
                  }
                  return ListView(
                    children: todos.map((todo) {
                      return ToDoListCard(
                        id: todo.id,
                        title: todo.judul,
                        category: todo.kategori,
                        deadline: todo.deadline,
                        isCompleted: todo.status == 'completed',
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(73),
              ),
              child: Center(
                child: TernaryButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddToDoPage()),
                    );
                  },
                  label: 'Tambah To-do List',
                  iconData: Icons.add_circle_outline_outlined,
                  width: 319,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlueCirclePlaceholder extends StatelessWidget {
  final double radiusValue;

  const BlueCirclePlaceholder({
    Key? key,
    required this.radiusValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radiusValue * 2,
      height: radiusValue * 2,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}