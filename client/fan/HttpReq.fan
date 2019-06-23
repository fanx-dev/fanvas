//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   8 Jan 09  Andy Frank  Creation
//   8 Jul 09  Andy Frank  Split webappClient into sys/dom
//

using concurrent

**
** HttpReq models the request side of an XMLHttpRequest instance.
**
** See [pod doc]`pod-doc#xhr` for details.
**
const class HttpReq
{
  ** Create a new HttpReq instance.
  new make(|This|? f := null)
  {
    if (f != null) f(this)
  }

  ** The Uri to send the request.
  const Uri uri := `#`

  ** The request headers to send.
  const Str:Str headers := Str:Str[:]

  const Int timeout := 10000

  **
  ** Indicates whether or not cross-site 'Access-Control' requests
  ** should be made using credentials such as cookies, authorization
  ** headers or TLS client certificates. Setting 'withCredentials' has
  ** no effect on same-site requests. The default is 'false'.
  **
  ** Requests from a different domain cannot set cookie values  for
  ** their own domain unless 'withCredentials' is set to 'true' before
  ** making the request. The third-party cookies obtained by setting
  ** 'withCredentials' to 'true' will still honor same-origin policy and
  ** hence can not be accessed by the requesting script through
  ** `Doc.cookies` or from response headers.
  **
  const Bool withCredentials := false

  **
  ** Send a request with the given content using the given
  ** HTTP method (case does not matter).  After receiving
  ** the response, call the given closure with the resulting
  ** HttpRes object.
  **
  native Promise<HttpRes> send(Str method, Obj? content)

  ** Convenience for 'send("GET", "", c)'.
  Promise<HttpRes> get()
  {
    send("GET", null)
  }

  ** Convenience for 'send("POST", content, c)'.
  Promise<HttpRes> post(Obj content)
  {
    send("POST", content)
  }
/*
  **
  ** Post the 'form' map as a HTML form submission.  Formats
  ** the map into a valid url-encoded content string, and sets
  ** 'Content-Type' header to 'application/x-www-form-urlencoded'.
  **
  Promise postForm(Str:Str form)
  {
    headers["Content-Type"] = "application/x-www-form-urlencoded"
    send("POST", encodeForm(form), c)
  }

  ** Encode the form map into a value URL-encoded string.
  private native Str encodeForm(Str:Str form)
  */
}