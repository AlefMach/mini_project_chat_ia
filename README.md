# BasicChat

  ![](logo.jpeg#vitrinedev)

  This is a simple project to simulate a IA of the conversation

  it's very simple, but the logic is the same used in big tech company

## Start

Make sure with you have all depedences necessary for run this project

The versions is provides in `.tool-versions`


## Install deps

run in your CLI

```shell
mix deps.get
```

after you made this can run

```shell
iex -S mix

iex> BasicChat.tell_me("Bom dia! como está?")
Estou bem, como posso ajudar?

bom dia!
:ok
```

the files that you can change is `lib/data.ex`

you can add more params to the file for the program identify what he can say to you.