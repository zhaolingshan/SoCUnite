import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/services/auth_service.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



final primaryColor = const Color(0xFF4DB6AC);
enum AuthFormType {signIn, signUp, reset}

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;
  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
    String _email, _password, _name, _warning;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if(state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if(form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }



  void submit() async {
    if(validate()) {
      // final form = formKey.currentState;
      // form.save();
      try {
        final auth = Provider.of(context).auth;
        if(authFormType == AuthFormType.signIn) {
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print("Signed in with ID $uid");
        Navigator.of(context).pushReplacementNamed('/home');
        } else if(authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("Password reset email sent");
          _warning = "A password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        }
        else { //creating a new user
        String uid = await auth.createUserWithEmailAndPassword(_email, _password, _name);
        //store email, password, name into firestore

        await Firestore.instance.collection('users').
        document(uid).setData({
          'username': _name,
          'email': _email,
          // 'timetable': null,
          // 'modules': null,
          
          //'password': _password, profile picture is stored in firebase storage
        }
        );
        print("Signed up with new ID $uid");
        Navigator.of(context).pushReplacementNamed('/home');
        }
    } catch (e) {
      setState(() {
        _warning = e.message;
      }
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
  
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.04,),
              showAlert(),
              SizedBox(height: _height * 0.025,),
              buildHeaderText(),
              SizedBox(height: _height * 0.02),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: Column(
                  children: buildInputs() + buildButtons(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );  
  }

  Widget showAlert() {
    if(_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: Text(_warning, maxLines: 3),),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _warning = null;
                }
                );
              }
              )
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }




  Text buildHeaderText() {
    String _headerText;
    if(authFormType == AuthFormType.signUp) {
      _headerText = "Sign Up";
    } else if (authFormType == AuthFormType.reset){
      _headerText = "Reset Password";
    } else {
      _headerText = "Sign in";
    }
    return Text(_headerText, maxLines: 1, textAlign: TextAlign.center,
               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white) 
              );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if(authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
        style: TextStyle(fontSize: 22),
        validator: EmailValidator.validate,
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
      return textFields;
    }

    //if were in the sign up state add name
    if(authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
        style: TextStyle(fontSize: 22),
        validator: NameValidator.validate,
        decoration: buildSignUpInputDecoration("Username"),
        onSaved: (value) => _name = value,
        ),
      );
    }
    textFields.add(SizedBox(height: 20));
    //add email and password
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 22),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 20));
    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 22),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 30));
    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0)),
          contentPadding: const EdgeInsets.only(left: 13, bottom:14, top:10, right: 13), 
        );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;

    if(authFormType == AuthFormType.signIn) {
      _switchButtonText = "Do not have an account? Sign up";
      _showForgotPassword = true;
      _newFormState = "signUp";
      _submitButtonText = "Login";
    } else if(authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Login";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
    }
    else {
      _switchButtonText = "Already have an account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign up";
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.12,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Colors.blue[300],
          textColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_submitButtonText, style: TextStyle(fontSize: 20, 
             fontWeight: FontWeight.bold),)
          ),
          onPressed: submit,
        ),
      ),
      showForgotPassword(_showForgotPassword),

      FlatButton(
        child: Text(_switchButtonText, style: TextStyle(color: Colors.white, 
        fontSize: 17)),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];

  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
      child: Text("Forgot Password?",
      style: TextStyle(color: Colors.white, fontSize: 17),),
      onPressed: () {
        setState(() {
          authFormType = AuthFormType.reset;
        });
      }),
      visible: visible,
    );
    }


}







