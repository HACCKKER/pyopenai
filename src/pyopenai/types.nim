import json


type
    OpenAiClient* = object
        apiKey*: string
        organization*: string
        userAgent*: string

type
    Completion* = JsonNode
    ChatCompletion* = JsonNode
    Image* = JsonNode

type
    ModelNotFound* = ref object of CatchableError
    InvalidApiKey* = ref object of CatchableError
    InvalidParameters* = ref object of CatchableError