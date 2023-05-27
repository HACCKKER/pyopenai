# PyOpenAI

<!-- [![Build status](https://github.com/HACCKKER/pyopenai/workflows/Build/badge.svg)](https://github.com/HACCKKER/pyopenai/actions) -->
![](https://img.shields.io/github/languages/top/HACCKKER/pyopenai?style=flat)
![](https://img.shields.io/github/languages/code-size/HACCKKER/pyopenai?style=flat)

An attempt to reimplement python OpenAI API bindings in nim

## Project Status:
- in developement (not a full OpenAI API spec implementation yet)
- async not implemented yet
- if you need features that are not implemented yet, try [this](https://nimble.directory/pkg/openaiclient)

#### What is already implemented:
- [Models](https://platform.openai.com/docs/api-reference/models)
- [Completions](https://platform.openai.com/docs/api-reference/completions)
- [ChatCompletions](https://platform.openai.com/docs/api-reference/chat)
- [Edits](https://platform.openai.com/docs/api-reference/edits)
- [Images](https://platform.openai.com/docs/api-reference/images)
- [Embeddings](https://platform.openai.com/docs/api-reference/embeddings)
- [Moderations](https://platform.openai.com/docs/api-reference/moderations)
- [Audio](https://platform.openai.com/docs/api-reference/audio/create)

# Installation
To install pyopenai, you can simply run
```
nimble install pyopenai
```
- Uninstall with `nimble uninstall pyopenai`.
- [Nimble repo page](https://nimble.directory/pkg/pyopenai)

# Requisites

- [Nim](https://nim-lang.org)

# Example
```nim
import pyopenai, json, os

var openai = OpenAiClient(
    apiKey: getEnv("OPENAI_API_KEY")
)

let response = openai.createCompletion(
    model = "text-davinci-003",
    prompt = "imo nim is the best programming language",
    temperature = 0.6,
    maxTokens = 500
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
    temperature = 0.5,
    maxTokens = 1000
)

chatMessages.add(
    resp["choices"][0]["message"]
)

echo(resp["choices"][0]["message"]["content"].str)
```
