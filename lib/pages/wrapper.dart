import 'package:flutter/material.dart';
import 'package:github_client/pages/gihub_login.dart';
import 'package:github_client/utilites/github_oauth_credentials.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
      builder: (context, httpClient) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: const Center(
            child: Text(
              'You are logged in to GitHub!',
            ),
          ),
        );
      },
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }
}
