import 'package:final_ctrl_alt_defeat/presenter/login_presenter.dart';
import 'package:flutter/material.dart';
import 'package:final_ctrl_alt_defeat/View/signup_page.dart';
import 'package:get/get.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final authControl = Get.put(loginPresenter());
    final loginFormKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("LOGIN"),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back)),
          ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("MyFit", style: TextStyle(fontSize: 35),),
                const Text("please login", style: TextStyle(fontSize: 15),),

                Form(
                  //key: loginFormKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: authControl.email,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              label: Text("E-mail", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                              hintText: "Enter you e-mail",
                              border: OutlineInputBorder(),
                        ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            controller: authControl.password,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.fingerprint),
                              labelText: "Password",
                              hintText: "Enter your password",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: null,
                                icon: Icon(Icons.remove_red_eye_sharp),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: (){
                                //if(loginFormKey.currentState!.validate()){
                                  loginPresenter.instance.logUserIn(authControl.email.text.trim(), authControl.password.text.trim());
                                //}
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                                  foregroundColor: Colors.white),
                              child: Text("Log In", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))
                              ),
                          ),
                        ],
                      ),
                    ),
                ),
                 Text("OR", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),

                SizedBox(
                  height: 30.0,
                ),

                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                        return SignupPage();
                      },
                      ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an Account? ",
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: "Signup", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}