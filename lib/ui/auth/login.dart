import 'package:flutter/material.dart';
import 'package:invoiceninja/redux/auth/auth_state.dart';
import 'package:invoiceninja/ui/app/progress_button.dart';
import 'package:invoiceninja/utils/localization.dart';

import '../app/form_card.dart';

class Login extends StatelessWidget {
  final bool isLoading;
  final bool isDirty;
  final AuthState authState;
  final Function(BuildContext, String, String, String, String) onLoginPressed;

  Login({
    Key key,
    @required this.isDirty,
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
  }) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>(debugLabel: 'email');
  static final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _urlKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _secretKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    if (!authState.isInitialized) {
      return Container();
    }

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: new Image.asset('assets/images/logo.png',
              width: 100.0, height: 100.0),
        ),
        Form(
          key: _formKey,
          child: FormCard(
            children: <Widget>[
              TextFormField(
                key: _emailKey,
                initialValue: authState.email,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context).email),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty || val.trim().length == 0
                    ? AppLocalization.of(context).pleaseEnterYourEmail
                    : null,
              ),
              TextFormField(
                key: _passwordKey,
                initialValue: authState.password,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context).password),
                validator: (val) => val.isEmpty || val.trim().length == 0
                    ? AppLocalization.of(context).pleaseEnterYourPassword
                    : null,
                obscureText: true,
              ),
              TextFormField(
                key: _urlKey,
                initialValue: authState.url,
                autocorrect: false,
                decoration:
                    InputDecoration(labelText: AppLocalization.of(context).url),
                validator: (val) => val.isEmpty || val.trim().length == 0
                    ? AppLocalization.of(context).pleaseEnterYourUrl
                    : null,
                keyboardType: TextInputType.url,
              ),
              TextFormField(
                key: _secretKey,
                initialValue: authState.secret,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context).secret),
                /*
                    validator: (val) => val.isEmpty || val.trim().length == 0
                        ? AppLocalization.of(context).pleaseEnterYourPassword
                        : null,
                        */
                obscureText: true,
              ),
              authState.error == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(top: 26.0, bottom: 4.0),
                      child: Center(
                        child: Text(
                          authState.error,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        ProgressButton(
          label: 'LOGIN',
          isLoading: this.isLoading,
          isDirty: this.isDirty,
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            }

            this.onLoginPressed(
                context,
                _emailKey.currentState.value,
                _passwordKey.currentState.value,
                _urlKey.currentState.value,
                _secretKey.currentState.value);
          },
        ),
      ],
    );
  }
}