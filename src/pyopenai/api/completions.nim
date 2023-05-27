import httpclient, json
import std/jsonutils

import ../types
import ../utils

proc createCompletion*(self: var OpenAiClient,
    model: string,
    prompt = "",
    suffix = "",
    maxTokens: uint = 0,
    temperature = 1.0,
    topP = 1.0,
    n: uint = 1,
    logprobs: uint = 0,
    echo = false,
    stop: string|seq[string] = "",
    presencePenalty = 0.0,
    frequencyPenalty = 0.0,
    bestOf: uint = 1,
    logitBias: JsonNode = %false,
    user = ""
    ): JsonNode =
    ## creates a `Completion`

    var body = %*{
        "model": model
    }

    if prompt != "":
        body.add("prompt", %prompt)
    
    if suffix != "":
        body.add("suffix", %suffix)

    if maxTokens != 0:
        body.add("max_tokens", %maxTokens)
    
    if temperature != 1.0:
        body.add("temperature", %temperature)
    
    if topP != 1.0:
        body.add("top_p", %topP)
    
    if n != 1:
        body.add("n", %n)
    
    if logprobs != 0:
        body.add("logprobs", %logprobs)
    
    if echo != false:
        body.add("echo", %echo)
    
    if stop != "":
        body.add("stop", %stop)
    
    if presencePenalty != 0.0:
        body.add("presence_penalty", %presencePenalty)
    
    if frequencyPenalty != 0.0:
        body.add("frequency_penalty", %frequencyPenalty)
    
    if bestOf != 1:
        body.add("best_of", %bestOf)
    
    if logitBias != %false:
        body.add("logit_bias", %logitBias)
    
    if user != "":
        body.add("user", %user)

    let resp = getOpenAiClient(self).post("https://api.openai.com/v1/completions",
            body = $body.toJson())
    case resp.status
        of $Http200:
            return resp.body.parseJson()
        of $Http401:
            raise invalidApiKey(msg: "Provided OpenAI API key is invalid")
        of $Http404:
            raise modelNotFound(msg: "The model that you selected does not exist")
        of $Http400:
            raise invalidParameters(msg: "Some of the parameters that you provided are invalid")
        else:
            raise newException(OSError, "Unknown error")


proc createChatCompletion*(self: var OpenAiClient,
    model: string,
    messages: seq[JsonNode],
    temperature = 1.0,
    topP = 1.0,
    n: uint = 1,
    stop: string|seq[string] = "",
    maxTokens: uint = 0,
    presencePenalty = 0.0,
    frequencyPenalty = 0.0,
    logitBias: JsonNode = %false,
    user = ""
    ): JsonNode =
    ## creates a `ChatCompletion`

    var body = %*{
        "model": model,
        "messages": messages
    }

    if temperature != 1.0:
        body.add("temperature", %temperature)
    
    if topP != 1.0:
        body.add("top_p", %topP)
    
    if n != 1:
        body.add("n", %n)
    
    if stop != "":
        body.add("stop", %stop)

    if maxTokens != 0:
        body.add("max_tokens", %maxTokens)
    
    if presencePenalty != 0.0:
        body.add("presence_penalty", %presencePenalty)
    
    if frequencyPenalty != 0.0:
        body.add("frequency_penalty", %frequencyPenalty)
    
    if logitBias != %false:
        body.add("logit_bias", %logitBias)
    
    if user != "":
        body.add("user", %user)

    let resp = getOpenAiClient(self).post("https://api.openai.com/v1/chat/completions",
            body = $body.toJson())
    case resp.status
        of $Http200:
            return resp.body.parseJson()
        of $Http401:
            raise invalidApiKey(msg: "Provided OpenAI API key is invalid")
        of $Http404:
            raise modelNotFound(msg: "The model that you selected does not exist")
        of $Http400:
            raise invalidParameters(msg: "Some of the parameters that you provided are invalid")
        else:
            raise newException(OSError, "Unknown error")