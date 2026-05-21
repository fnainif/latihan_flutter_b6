import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan_flutter_b6/latihan/tugas7_snk.dart';

class TugasDay15 extends StatefulWidget {
  const TugasDay15({super.key});

  @override
  State<TugasDay15> createState() => _TugasDay15State();
}

class _TugasDay15State extends State<TugasDay15> {
  bool isSwitch = false;
  String? selectedDropdown;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Interaktif")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Tes Header Drawer")),
            ListTile(title: TosButton(drawer: "Term of Service")),
            ListTile(title: FormButton(drawer: "Form")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: isSwitch,
                  onChanged: (bool? value) {
                    setState(() {});
                    isSwitch = value ?? false;
                  },
                ),
                SizedBox(width: 10),
                Text(isSwitch ? "Dark mode" : "Light mode"),
              ],
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          SizedBox.expand(
            child: isSwitch
                ? Expanded(child: Container(color: Colors.black))
                : Expanded(child: Container(color: Colors.white)),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Text("New event", style: TextStyle(color: Colors.amber)),

              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSwitch
                              ? const Color.fromARGB(255, 13, 102, 57)
                              : Colors.amberAccent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextField(),
                            Row(
                              children: [
                                Text("Priority"),
                                SizedBox(width: 40),
                                DropdownButton<String>(
                                  value: selectedDropdown,
                                  items:
                                      [
                                        "Low priority",
                                        "Mid priority",
                                        "High priority",
                                      ].map((String val) {
                                        return DropdownMenuItem(
                                          value: val,
                                          child: Text(val),
                                        );
                                      }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {});
                                    selectedDropdown = value;
                                  },
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text("Date"),
                                SizedBox(width: 40),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1990),
                                          lastDate: DateTime(2100),
                                        );
                                    if (picked != null) {
                                      setState(() {
                                        selectedDate = picked;
                                      });
                                    }
                                  },
                                  label: Text("Pilih Tanggal"),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  DateFormat(
                                    'EEE, dd MMMM yyyy',
                                  ).format(selectedDate ?? DateTime.now()),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text("Time"),
                                SizedBox(width: 40),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final TimeOfDay? picked =
                                        await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                    if (picked != null) {
                                      setState(() {
                                        selectedTime = picked;
                                      });
                                    }
                                  },
                                  label: Text("Pilih Jam"),
                                ),
                                SizedBox(width: 40),
                                Text(
                                  selectedTime == null
                                      ? ""
                                      : selectedTime!.format(context),
                                ),
                              ],
                            ),

                            ElevatedButton(
                              onPressed: () {
                                if (selectedDate != null &&
                                    selectedDropdown != null &&
                                    selectedTime != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Tugas7snk(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Semua data harus diisi terlebih dahulu",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TosButton extends StatelessWidget {
  const TosButton({super.key, required this.drawer});
  final String drawer;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tugas7snk()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          drawer,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 194, 19, 19)),
        ),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({super.key, required this.drawer});
  final String drawer;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TugasDay15()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          drawer,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 161, 29, 29)),
        ),
      ),
    );
  }
}
