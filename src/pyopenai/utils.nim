import httpclient
import strformat

import types

proc getOpenAiClient*(client: OpenAiClient): HttpClient =

    var openAiHeaders = newHttpHeaders(
        [
            ("Content-Type", "application/json"),
            ("Authorization", fmt"Bearer {client.apiKey}")
        ]
    )

    if client.organization != "":
        openAiHeaders.add("OpenAI_Organization", client.organization)

    if client.userAgent != "":
        openAiHeaders.add("User-Agent", client.userAgent)

    return newHttpClient(headers = openAiHeaders)