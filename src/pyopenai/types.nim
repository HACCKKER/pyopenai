type
    OpenAiClient* = object
        apiKey*: string
        organization*: string
        userAgent*: string

type
    modelNotFound* = ref object of CatchableError
    invalidApiKey* = ref object of CatchableError
    invalidParameters* = ref object of CatchableError