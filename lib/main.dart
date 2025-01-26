import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instant1/app_dio/app_dio.dart';
import 'package:instant1/before_interview/database/test2_db.dart';
import 'package:instant1/before_interview/database/test_db.dart';
import 'package:instant1/e_learning/stripe_payment/stripe_keys.dart';
import 'package:instant1/news/ui/news_main.dart';
import 'package:instant1/notifications/notification.dart';
import 'package:instant1/project_one_work/page/new_home_page/new_home.dart';
import 'package:instant1/project_one_work/page/test1.dart';
import 'package:instant1/task21/first_screen.dart';
import 'package:instant1/task23/first_screen.dart';
import 'package:instant1/ui/log_in.dart';
import 'package:instant1/ui/notes/database/note_database.dart';
import 'package:instant1/ui/notes/shared.dart';
import 'package:instant1/ui/notes/ui/home/page/home_screen.dart';
import 'package:instant1/ui/notes/ui/register/page/register_screen.dart';
import 'package:instant1/ui/state_managment/counter/counter_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'before_interview/ui_test/text_ui.dart';
import 'e_learning/ui/home/home.dart';
import 'e_learning/ui/login/page/login.dart';
import 'in/t1.dart';
import 'in/ui/t1_e.dart';
import 'in/ui/t2_e.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
// Navigator.pushReplacement(context,
// MaterialPageRoute(
// builder: (context)=>const HomeScreen(),
// ),
// );

void main() async{
  Stripe.publishableKey=ApiKeys.publishableKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.subscribeToTopic("TP1TO");
  await PreferenceUtils.init();
  await NoteDatabase.init();
  await EcommerceDatabase.init();
  //await ItemPurchase.createTablePurchase();
  //await ItemPurchase.createTableItem();
  await DB.init();
  initNotifications();
  AppDio.init();
  FirebaseMessaging.instance.getToken()
      .then((value) {
        print("FCM token => $value");
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      print('Message also contained a notification: ${message.notification!.title}');
      print('Message also contained a notification: ${message.notification!.body}');
      displayNotification(message.notification!.title!,
          message.notification!.body!);
    }
  });

  runApp(const MyApp());
  //to try the app on different phones and see how it look like
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(), // Wrap your app
  //   ),
  // );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Platform.isAndroid){
      requestAndroidPermission();
    }
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home:INt()
          home: LoginOraclePage(),
          // home: NewHomeScreen(),
          // home:const ELoginScreen(),
          // home :FirebaseAuth.instance.currentUser==null
          //    ?const ELoginScreen()
          //    :const EHome(),
          // home:FirebaseAuth.instance.currentUser==null
          //     ?const LI()
          //     :const HomeScreen(),
          // home: RentickleFirstScreen(),
          //home: CounterPage(),

          // home: FacebookLogin(),
        );
      },
    );


  }
}



class Sebha extends StatefulWidget {
  const Sebha({super.key});

  @override
  State<Sebha> createState() => _SebhaState();
}

class _SebhaState extends State<Sebha> {
  int number=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سبحة"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
            number.toString(),
          style:const  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 70
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              onPressed: (){
                setState(() {
                  number=0;
                });
              },
            child: const Icon(Icons.undo,),
          ),
          const SizedBox(height: 25),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                number++;
              });
            },
            child: const Icon(Icons.add,),
          ),
          const SizedBox(height: 25),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                number--;
              });
            },
            child: const Icon(Icons.minimize,),
          )
        ],
      ),
    );
  }
}


class ExpandScreen extends StatefulWidget {
  const ExpandScreen({super.key});

  @override
  State<ExpandScreen> createState() => _ExpandScreenState();
}

class _ExpandScreenState extends State<ExpandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
              child: Container(
                color: Colors.black,height: 100,
              )
          ),
          Expanded(
              child: Container(
                color: Colors.blue,
              )
          ),
          Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                    color: Colors.grey,
                  ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.pink,
                    ),
                  ),
                ],
              )
          ),
          Expanded(
              child: Container(
                color: Colors.green,
              )
          ),
        ],
      ),
    );
  }
}










class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Layouts=> Column,Row,Stack
  bool obscureText=true;
  final emailController=TextEditingController();
  final passController=TextEditingController();


  //=>Form validation
  //Define form key
  //wrap Column with form
  //bind form key with form
  //write your validation in TextFormField
  //call form key for validation


  final formKey=GlobalKey<FormState>();

  void login(){
    if(!formKey.currentState!.validate()){
      return;
    }

    void displaySnackBar(String message){
      var snackBar=SnackBar(
        content: Text(message)
        ,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    void displayToast(String message){
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    String email=emailController.text;
    String pass=passController.text;
    if ( email == "Mohamed@gmail.com" && pass == "123456789"){
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context)=>const HomeScreen(),
          ),
      );
    }
    else{
      print("Wrong Email or Password");
      displayToast("Wrong Email or Password");
      //displaySnackBar("Wrong Email or Password");
    }




  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            //Vertical => main
            //Horizontal => cross
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const  InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
                validator:(value){
                  if(value!.isEmpty){
                    return "Email required" ;
                  }
                  //doesn't contain @ or .
                  if(!value.contains("@")||!value.contains(".") ){
                    return "Invalid email" ;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passController,
                obscureText: obscureText,
                decoration:   InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          obscureText=!obscureText;
                        });
                      },
                      icon:obscureText?const Icon(Icons.visibility_off):const Icon(Icons.visibility)
                  )
                ),
                validator:(value){
                  if(value!.isEmpty){
                    return "Password required" ;
                  }
                  if(value.length<5 ){
                    return "Password must be at least 6 Characters" ;
                  }
                  return null;
                },
                ),
              const SizedBox(height: 15),
              Row(
                //main => Vertical
                //cross => Horizontal
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(//better to use sizeBox
                      child: ElevatedButton(
                        onPressed: (){
                          login();
                          },
                        style: ElevatedButton.styleFrom(shape: const StadiumBorder(),),
                        child: const Text("Enter")
                      )
                  ),
                  Expanded(//better to use sizeBox
                      child: OutlinedButton(
                          onPressed: (){NavToRegisterScreen(context);},
                          style: ElevatedButton.styleFrom(shape: const StadiumBorder(),foregroundColor: Colors.blueAccent,backgroundColor: Colors.white),
                          child: const Text("Register")
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




//to be able to open another screen we need Navigator
//it is like the stack it have push and pop
// the push to open a new screen
// the pop to pop the open screen
NavToRegisterScreen(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>const RegisterScreen()),//it will call the screen Register
  );
}






class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      leading: const Icon(Icons.menu),
      title: const Text('First Screen'),
      actions: const [
        Icon(Icons.favorite),
        Icon(Icons.search),
        Icon(Icons.more_vert),
      ],
      backgroundColor: Colors.purple,
    ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
        centerTitle: true,
        actions: [
          IconButton(onPressed:(){
            print("search");
          } , icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: ()=>print("notification"),
            icon: const Icon(Icons.notifications),
          ),
        ],
        backgroundColor: Colors.green,
      ),

    );
  }
}






class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
