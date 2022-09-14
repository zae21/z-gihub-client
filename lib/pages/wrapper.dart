import 'package:flutter/material.dart';
import 'package:github_client/pages/gihub_login.dart';
import 'package:github_client/utilites/github_oauth_credentials.dart';
import 'package:github/github.dart';
import 'package:window_to_front/window_to_front.dart';

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
        WindowToFront.activate();
        return FutureBuilder<CurrentUser>(
          future: viewerDetail(httpClient.credentials.accessToken),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Center(
                child: Text(
                  snapshot.hasData
                      ? 'Hello ${snapshot.data!.login}!'
                      : 'Retrieving viewer login details...',
                ),
              ),
            );
          },
        );
      },
      githubClientId: githubClientId,
      githubClientSecret: githubClientSecret,
      githubScopes: githubScopes,
    );
  }

  Future<CurrentUser> viewerDetail(String accessToken) async {
    final gitHub = GitHub(auth: Authentication.withToken(accessToken));
    return gitHub.users.getCurrentUser();
  }
}
