import httpclient

import types

proc buildHttpClient*(client: OpenAiClient, contentType: string): HttpClient =

    var openAiHeaders = newHttpHeaders(
        [
            ("Content-Type", contentType),
            ("Authorization", "Bearer "&client.apiKey)
        ]
    )

    if client.organization != "":
        openAiHeaders.add("OpenAI_Organization", client.organization)

    if client.userAgent != "":
        openAiHeaders.add("User-Agent", client.userAgent)

    return newHttpClient(headers = openAiHeaders)