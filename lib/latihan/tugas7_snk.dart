import 'package:flutter/material.dart';

class Tugas7snk extends StatefulWidget {
  const Tugas7snk({super.key});

  @override
  State<Tugas7snk> createState() => _Tugas7snkState();
}

class _Tugas7snkState extends State<Tugas7snk> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/bg_tugas.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                SizedBox(height: 40),
                Text("Term and Condition"),
                Text(
                  "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...",
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas vel tellus enim. Quisque mattis euismod erat, vitae pretium elit laoreet non. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In et turpis id nisl interdum pulvinar. Integer consectetur purus sit amet dui condimentum venenatis. Proin tincidunt scelerisque orci a egestas. Phasellus viverra massa et lectus cursus vestibulum. Sed pretium in nunc ac tincidunt.\n\nMauris dignissim orci tortor, vel eleifend tortor hendrerit sit amet. Mauris ultrices lorem vitae ante eleifend, et imperdiet nisl fringilla. Mauris congue nunc quis ornare hendrerit. Aliquam ornare imperdiet nulla et sollicitudin. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam pretium dolor eu nisl feugiat, at mattis lacus lobortis. Phasellus vestibulum sollicitudin lectus, id pretium dolor tempor sit amet. Aenean at massa eu urna consectetur tempor at in augue.\n\nPraesent tincidunt libero lorem, id efficitur tortor efficitur eget. Proin sed purus viverra, maximus nibh sit amet, semper quam. Vivamus eget fermentum ex. Aenean dictum enim sed nunc sodales volutpat. Aenean libero metus, porta ut ligula eget, feugiat fringilla orci. Sed elementum tortor dolor, id pharetra sem scelerisque sit amet. Donec consectetur tristique tortor, id hendrerit ipsum lacinia eu. Donec ullamcorper nisi nunc, et dictum diam hendrerit eget. Praesent rhoncus sollicitudin nulla in molestie. Vestibulum sed nunc et risus egestas scelerisque. Vestibulum pretium, diam at dictum dapibus, nisi ante sagittis quam, eget porttitor tellus odio ut dui. Sed id diam odio. In odio dolor, molestie eu urna hendrerit, molestie semper dolor. Nullam quis orci sit amet turpis euismod sollicitudin a quis lectus.\n\nPraesent id rutrum felis, fermentum condimentum diam. Suspendisse vitae varius augue. Quisque feugiat, mauris lobortis varius consectetur, sapien lacus volutpat purus, eget rhoncus enim ligula vel nulla. Phasellus sodales aliquet ligula at commodo. Pellentesque ut sem quis est commodo vehicula nec nec urna. Phasellus nec placerat nisi. Duis malesuada sodales nunc vel imperdiet. Curabitur vitae lectus volutpat, molestie magna eget, porta elit. Donec quis magna non sapien egestas lacinia. Nulla et arcu imperdiet, rhoncus leo ac, accumsan sapien. Cras dapibus elit sed nunc hendrerit fringilla. Suspendisse at odio arcu. Sed tristique, odio ut fringilla sollicitudin, lacus lectus commodo nunc, at lacinia ex felis venenatis augue. Nulla porta libero nisl, ornare luctus enim feugiat eu. Cras at ipsum a nulla convallis ultricies. Nullam sodales elementum viverra.\n\nNulla at suscipit mauris. Nunc varius massa ex, sit amet placerat leo fringilla a. Maecenas sit amet pellentesque metus, sed pharetra ligula. Praesent convallis volutpat ipsum, tempus aliquam odio tincidunt non. Vestibulum ante leo, iaculis et pulvinar eget, pretium nec libero. Integer odio odio, finibus id ultrices non, sodales sed turpis. Cras quis augue id nibh venenatis euismod nec efficitur urna. Nullam tempus elementum dui, nec iaculis dolor. Proin fermentum sapien ac nisl rutrum mattis. Maecenas aliquet enim quis dignissim euismod. Aenean ex est, fermentum sed tincidunt sed, tincidunt quis erat. Nullam lorem augue, pretium pulvinar consequat vel, varius at enim.",
                      ),
                      Divider(),
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            onChanged: (bool? value) {
                              setState(() {});
                              isCheck = value ?? false;
                            },
                          ),
                          Text(
                            isCheck
                                ? "Pendaftaran diperbolehkan"
                                : "Pendaftaran belum tersedia",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
