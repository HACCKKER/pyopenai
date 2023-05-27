import httpclient, json

import ../consts
import ../types
import ../utils


proc getModelList*(self: OpenAiClient): JsonNode =
    return buildHttpClient(self, "application/json").get(OpenAiBaseUrl&"/models").body.parseJson()

proc getModel*(self: OpenAiClient, model: string): JsonNode =
    return buildHttpClient(self, "application/json").get(OpenAiBaseUrl&"/models/"&model).body.parseJson()