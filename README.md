# PyOpenAI

[![Build status](https://github.com/HACCKKER/pyopenai/workflows/Build/badge.svg)](https://github.com/HACCKKER/pyopenai/actions)
![](https://img.shields.io/github/languages/top/HACCKKER/pyopenai?style=flat)
![](https://img.shields.io/github/languages/code-size/HACCKKER/pyopenai?style=flat)

An attempt to reimplement python OpenAI API bindings in nim

## Project Status:
- in developement (not a full OpenAI API spec implementation yet)

# Installation
To install pyopenai, you can simply run
```
nimble install pyopenai
```
- Uninstall with `nimble uninstall pyopenai`.
- [Nimble repo page](https://nimble.directory/pkg/)

# Requisites

- [Nim](https://nim-lang.org)

# Example
```nim
import pyopenai
import json

var openai = OpenAiClient(
    apiKey: "OPENAI_API_KEY"
)

let response = openai.createCompletion(
    model = "text-davinci-003",
    prompt = "imo nim is the best programming language",
    temperature = 1,
    maxTokens = 2048
)

echo(response["choices"][0]["text"].str)

echo()

var chatMessages: seq[JsonNode]

chatMessages.add(
    %*{"role": "user", "content": "imo nim is the best programming language"}
)

let resp = openai.createChatCompletion(
    model = "gpt-3.5-turbo",
    messages = chatMessages,
    temperature = 1,
    maxTokens = 2048
)

chatMessages.add(
    resp["choices"][0]["message"]
)

echo(resp["choices"][0]["message"]["content"].str)
```