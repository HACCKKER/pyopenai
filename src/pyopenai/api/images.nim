import httpclient, json
import std/jsonutils

import ../consts
import ../types
import ../utils


proc createImage*(self: OpenAiClient,
    prompt: string,
    n: uint = 1,
    size = "1024x1024",
    responseFormat = "url",
    user = ""
    ): Image =
    ## creates an `Image`

    var body = %*{
        "prompt": prompt
    }

    if n != 1:
        body.add("n", %n)

    if size != "1024x1024":
        body.add("size", %size)

    if responseFormat != "url":
        body.add("response_format", %responseFormat)

    if user != "":
        body.add("user", %user)

    let resp = buildHttpClient(self, "application/json").post(OpenAiBaseUrl&"/images/generations",
            body = $body.toJson())
    case resp.status
        of $Http200:
            return resp.body.parseJson()
        of $Http401:
            raise InvalidApiKey(msg: "Provided OpenAI API key is invalid")
        of $Http404:
            raise ModelNotFound(msg: "The model that you selected does not exist")
        of $Http400:
            raise InvalidParameters(msg: "Some of the parameters that you provided are invalid")
        else:
            raise newException(OSError, "Unknown error")
