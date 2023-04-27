part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String title = "Demo Background Task";
  bool bcgSrvc = false;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
        title: title,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.all(15),
              child: const SizedBox(),
            ),
            Material(
              color: Colors.redAccent[200],
              borderRadius: BorderRadius.circular(20),
              child: bcgSrvc
                  ? InkWell(
                      splashColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        await Workmanager().cancelAll();
                        setState(() {
                          bcgSrvc = false;
                        });
                      },
                      child: Center(
                        child: Text(
                          "Stop Background Task",
                          style: blackFontStyle5,
                        ),
                      ),
                    )
                  : InkWell(
                      splashColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        var uId = DateTime.now().second.toString();
                        await setPermission().checkPermit();
                        await Workmanager().registerPeriodicTask(uId, task,
                            frequency: const Duration(minutes: 15),
                            constraints: Constraints(
                                networkType: NetworkType.connected));
                        setState(() {
                          bcgSrvc = true;
                        });
                      },
                      child: Center(
                        child: Text(
                          "Start Background Task",
                          style: blackFontStyle5,
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
