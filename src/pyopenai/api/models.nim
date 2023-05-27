import httpclient, json

import ../consts
import ../types
import ../utils


proc getModelList*(self: OpenAiClient): JsonNode =
    let resp = buildHttpClient(self, "application/json").get(
            OpenAiBaseUrl&"/models")
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
            raise newException(Defect, "Unknown error")

proc getModel*(self: OpenAiClient, model: string): JsonNode =
    let resp = buildHttpClient(self, "application/json").get(
            OpenAiBaseUrl&"/models/"&model)
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
            raise newException(Defect, "Unknown error")
