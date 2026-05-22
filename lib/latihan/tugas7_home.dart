import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan_flutter_b6/latihan/loginkosong.dart';
import 'package:latihan_flutter_b6/latihan/tugas7_drawer.dart';

class TugasDay15 extends StatefulWidget {
  const TugasDay15({super.key, required this.isSwitch});
  final bool isSwitch;
  @override
  State<TugasDay15> createState() => _TugasDay15State();
}

class _TugasDay15State extends State<TugasDay15> {
  late bool isSwitch;
  String? selectedDropdown;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    isSwitch = widget.isSwitch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Event")),
      drawer: Tugas7Drawer(
        isSwitch: isSwitch,

        onChanged: (value) {
          setState(() {
            isSwitch = value;
          });
        },
      ),

      body: Stack(
        children: [
          SizedBox.expand(
            child: isSwitch
                ? Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 83, 43, 63),
                    ),
                  )
                : Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 255, 161, 233),
                    ),
                  ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Text(
                "New event",
                style: TextStyle(
                  color: const Color.fromARGB(255, 248, 231, 241),

                  fontSize: 40,
                ),
              ),

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
                              ? const Color.fromARGB(255, 53, 6, 35)
                              : const Color.fromARGB(255, 248, 231, 241),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextField(
                              style: TextStyle(
                                color: isSwitch
                                    ? const Color.fromARGB(255, 243, 232, 240)
                                    : const Color.fromARGB(255, 196, 110, 176),
                              ),
                              decoration: InputDecoration(
                                hintText: "Write your event",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(149, 119, 119, 119),
                                ),

                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(50, 156, 155, 155),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Priority",
                                  style: TextStyle(
                                    color: isSwitch
                                        ? const Color.fromARGB(
                                            255,
                                            243,
                                            232,
                                            240,
                                          )
                                        : const Color.fromARGB(
                                            255,
                                            196,
                                            110,
                                            176,
                                          ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                DropdownButton<String>(
                                  value: selectedDropdown,
                                  dropdownColor: isSwitch
                                      ? Colors.black
                                      : Colors.white,

                                  iconEnabledColor: isSwitch
                                      ? Colors.white
                                      : Colors.black,

                                  style: TextStyle(
                                    color: isSwitch
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255,
                                            196,
                                            110,
                                            176,
                                          ),
                                  ),
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
                                SizedBox(width: 20),
                              ],
                            ),

                            Row(
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                    color: isSwitch
                                        ? const Color.fromARGB(
                                            255,
                                            243,
                                            232,
                                            240,
                                          )
                                        : const Color.fromARGB(
                                            255,
                                            196,
                                            110,
                                            176,
                                          ),
                                  ),
                                ),
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
                                  label: Text(
                                    "Pilih Tanggal",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        196,
                                        110,
                                        176,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                              ],
                            ),

                            Row(
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(
                                    color: isSwitch
                                        ? const Color.fromARGB(
                                            255,
                                            243,
                                            232,
                                            240,
                                          )
                                        : const Color.fromARGB(
                                            255,
                                            196,
                                            110,
                                            176,
                                          ),
                                  ),
                                ),
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
                                  label: Text(
                                    "Pilih Jam",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        196,
                                        110,
                                        176,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                              ],
                            ),

                            Divider(),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 30,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isSwitch
                                    ? const Color.fromARGB(255, 243, 232, 240)
                                    : const Color.fromARGB(255, 196, 110, 176),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Summary",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: isSwitch
                                          ? const Color.fromARGB(
                                              255,
                                              196,
                                              110,
                                              176,
                                            )
                                          : const Color.fromARGB(
                                              255,
                                              243,
                                              232,
                                              240,
                                            ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Prioritas dipilih : \n${selectedDropdown ?? "-"}",
                                        style: TextStyle(
                                          color: isSwitch
                                              ? const Color.fromARGB(
                                                  255,
                                                  196,
                                                  110,
                                                  176,
                                                )
                                              : const Color.fromARGB(
                                                  255,
                                                  243,
                                                  232,
                                                  240,
                                                ),
                                          fontSize: 16,
                                        ),
                                      ),

                                      Text(
                                        "Tanggal dipilih :\n${DateFormat('EEE, dd MMMM yyyy').format(selectedDate ?? DateTime.now())}",
                                        style: TextStyle(
                                          color: isSwitch
                                              ? const Color.fromARGB(
                                                  255,
                                                  196,
                                                  110,
                                                  176,
                                                )
                                              : const Color.fromARGB(
                                                  255,
                                                  243,
                                                  232,
                                                  240,
                                                ),
                                        ),
                                      ),

                                      Text(
                                        "Pengingat dipilih :\n${selectedTime == null ? "" : selectedTime!.format(context)}",
                                        style: TextStyle(
                                          color: isSwitch
                                              ? const Color.fromARGB(
                                                  255,
                                                  196,
                                                  110,
                                                  176,
                                                )
                                              : const Color.fromARGB(
                                                  255,
                                                  243,
                                                  232,
                                                  240,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),

                            ElevatedButton(
                              onPressed: () {
                                if (selectedDate != null &&
                                    selectedDropdown != null &&
                                    selectedTime != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Loginkosong(),
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
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    196,
                                    110,
                                    176,
                                  ),
                                ),
                              ),
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
