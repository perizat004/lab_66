import 'package:flutter/material.dart';
import 'package:flutter_application_66/user_info.dart';

// RegistrationPage - пайдаланушы тіркеу формасын құрайтын StatefulWidget
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Форма күйін басқару үшін GlobalKey
  final _formKey = GlobalKey<FormState>();

  // Әрбір енгізу өрісі үшін TextEditingController-лер
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _storyController = TextEditingController();

  // Әрбір өріс үшін FocusNode-дар (фокус күйін бақылау)
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _storyFocus = FocusNode();

  // Құпия сөздерді көрсету/жасыру логикасы
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    // Контроллерлер мен FocusNode-дарды босату (ресурстарды тазарту)
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _storyController.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _phoneFocus.dispose();
    _storyFocus.dispose();

    super.dispose();
  }

  // Форма жіберілген кезде шақырылатын функция
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Егер формадағы мәліметтер дұрыс толтырылған болса, UserInfoPage бетіне өту
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoPage(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            story: _storyController.text,
          ),
        ),
      );
    }
  }

  // Email енгізуді тексеру функциясы
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Введите email';
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) return 'Введите корректный email';
    return null;
  }

  // Құпия сөзді тексеру функциясы
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Введите пароль';
    if (value.length < 6) return 'Пароль должен быть не менее 6 символов';
    return null;
  }

  // Телефон нөмірін тексеру функциясы
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Введите номер телефона';
    if (!RegExp(r'^\d+$').hasMatch(value)) return 'Введите только цифры';
    return null;
  }

  // Енгізу өрістері үшін InputDecoration (безендіру) функциясы
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label, // Өрістің атауы
      prefixIcon: Icon(icon), // Алғашқы иконка
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)), // Жиектері дөңгелек
      // Егер өріс аты "Full Name" немесе "Phone Number" болса, тазалау батырмасы қосылады
      suffixIcon: label == 'Full Name' || label == 'Phone Number'
          ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                if (label == 'Full Name') _nameController.clear();
                if (label == 'Phone Number') _phoneController.clear();
              },
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Экран өлшемін клавиатура шыққанда өзгертуге мүмкіндік береді
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Register Form'),
        backgroundColor: Colors.blue,
      ),
      // SingleChildScrollView қолдану арқылы экранда орын таусылған жағдайда прокрутка жасалады
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16.0), // Барлық жағынан 16 пиксель бос орын
        child: Form(
          key: _formKey, // Форма күйін басқару кілті
          child: Column(
            children: [
              // Аты-жөнін енгізу өрісі
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: _inputDecoration('Full Name *', Icons.person),
                validator: (value) => value!.isEmpty ? 'Введите имя' : null,
              ),
              SizedBox(height: 10),
              // Телефон нөмірін енгізу өрісі
              TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Phone Number *', Icons.phone),
                validator: _validatePhone,
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone format: (XXX)XXX-XXXX',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              // Электрондық пошта енгізу өрісі
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                decoration: _inputDecoration('Email Address', Icons.email),
                validator: _validateEmail,
              ),
              SizedBox(height: 10),
              // Өмір тарихын енгізу өрісі
              TextFormField(
                controller: _storyController,
                focusNode: _storyFocus,
                decoration: _inputDecoration('Life Story', Icons.book),
                maxLines: 3, // Көп жолды мәтін енгізуге мүмкіндік береді
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Keep it short, this is just a demo',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              // Құпия сөз енгізу өрісі
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocus,
                obscureText: _obscurePassword, // Құпия сөзді жасыру
                decoration: InputDecoration(
                  labelText: 'Password *',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // Құпия сөзді көрсету/жасыру батырмасы
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: _validatePassword,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_passwordController.text.length}/8',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              // Құпия сөзді растау өрісі
              TextFormField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocus,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password *',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // Растау үшін құпия сөзді көрсету/жасыру батырмасы
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != _passwordController.text)
                    return 'Пароли не совпадают';
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_confirmPasswordController.text.length}/8',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 15),
              // Форманы жіберу батырмасы
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Submit Form',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
