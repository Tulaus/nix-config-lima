{ ... }:
{
  programs.git = {
    enable = true;
    settings.user = {
      name = "TulausDev";
      email = "TulausDev@users.noreply.github.com";
    };
    signing = {
      signByDefault = true;
      key = "9E7DE85D1E749EB5";
    };
    settings.credential.helper = "store";
  };
}
