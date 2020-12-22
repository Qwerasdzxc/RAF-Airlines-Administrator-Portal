import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raf_airlines_admin/dashboard/dashboard_page.dart';
import 'package:raf_airlines_admin/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController(text: "admin");
  TextEditingController _passwordController = TextEditingController(text: "admin");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.indigo[900], Colors.lightBlue])),
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessful)
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => DashboardPage()));
            },
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width / 6,
                            child: Image.asset("assets/raf_logo.jpg")),
                        SizedBox(
                          width: 24,
                        ),
                        Text(
                          "RAF Airlines",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                              fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Username",
                                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  TextField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Password",
                                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(context).primaryColorDark),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  color: Theme.of(context).primaryColor,
                                  child: FlatButton(
                                    onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                                        LoginCredentialsProvided(
                                            username: _usernameController.text,
                                            password: _passwordController.text)),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black12,
                                  ),
                                ),
                              ],
                            ),
                            if (state is LoginError)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "Login credentials invalid!",
                                    style:
                                        TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonPadding: const EdgeInsets.symmetric(horizontal: 8),
                    children: <Widget>[
                      Text("About", style: TextStyle(color: Colors.white)),
                      Text("·", style: TextStyle(color: Colors.white)),
                      Text("Home", style: TextStyle(color: Colors.white)),
                      Text("·", style: TextStyle(color: Colors.white)),
                      Text("Blog", style: TextStyle(color: Colors.white)),
                      Text("·", style: TextStyle(color: Colors.white)),
                      Text("Support", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
