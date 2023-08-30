import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymgenius/utils/colors.dart';
import 'package:gymgenius/views/workouts_view.dart';
// import 'package:nubank/views/home/widgets/header_widget.dart';
// import 'package:nubank/views/home/widgets/account_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('lib/assets/logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Nome de Usuário',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Senha',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    child: const Text('Entrar'),
                    onPressed: (){
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      // Aqui você pode fazer alguma ação com os dados inseridos
                      if (username == 'gym' && password == 'gym') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WorkoutsView()),
                        );
                      }
                    },
                  )
                )
              )
            ],
          )
      ),
    );
  }

  PreferredSize _appBar(){
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }
}
