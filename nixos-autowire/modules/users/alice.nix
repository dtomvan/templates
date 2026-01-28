{ self, ... }:
{
  users.alice = {
    fullName = "Alice Doe";
    email = "hi@example.com";
    gpgPubKey = "AAAAAAAAAAAAAAAA";
    locale = "C";
    timeZone = "UTC";
  };

  flake.modules.homeManager.users-alice.imports = with self.modules.homeManager; [
    base
    git
    jujutsu
  ];
}
