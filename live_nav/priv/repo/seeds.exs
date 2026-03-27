alias LiveNav.Repo
alias LiveNav.Servers.Server

%Server{
  name: "dancing-lizard",
  status: "up",
  deploy_count: 14,
  size: 19.5,
  framework: "Elixir/Phoenix",
  last_commit_message: "If this works, I'm going disco dancing. 🦎"
}
|> Repo.insert!()

%Server{
  name: "lively-frog",
  status: "up",
  deploy_count: 12,
  size: 24.0,
  framework: "Elixir/Phoenix",
  last_commit_message: "Hopping on this rocket ship! 🚀"
}
|> Repo.insert!()

%Server{
  name: "curious-raven",
  status: "up",
  deploy_count: 21,
  size: 17.25,
  framework: "Ruby/Rails",
  last_commit_message: "Fixed a bug! 🐞"
}
|> Repo.insert!()

%Server{
  name: "cryptic-owl",
  status: "down",
  deploy_count: 2,
  size: 5.0,
  framework: "Elixir/Phoenix",
  last_commit_message: "Woot! First big launch! 🤞"
}
|> Repo.insert!()
