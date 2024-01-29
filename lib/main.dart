import 'package:flutter/material.dart';
import 'package:lawod/components/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/authentication_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: "https://jygarouldipjiciutnlg.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5Z2Fyb3VsZGlwamljaXV0bmxnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYyMDA4NzcsImV4cCI6MjAyMTc3Njg3N30.-bxjnhydAnslNGGAtkZ3DLXUyDXiIVISeWCE13MaGBA",
    debug: true,
  );

  runApp(const Lawod());
}

class Lawod extends StatelessWidget {
  const Lawod({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthenticationPage(),
      ),
    );
  }
}
