enum RoutePath {
  splash(path: '/splash', label: 'splash'),
  signIn(path: '/sign-in', label: 'login'),
  signUp(path: '/sign-up', label: 'register'),
  main(path: '/main', label: 'main'),
  editProfile(path: '/profile', label: 'edit profile'),
  ;

  final String path;
  final String label;

  const RoutePath({required this.path, required this.label});
}
