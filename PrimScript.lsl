string url;
key urlRequestId;
key selfCheckRequestId;
key requestBoxID;  // just to check if we're getting the result we've asked for; all scripts in the same object get the same replies
key requestChatID;
integer listenHandle;
 
request_url()
{
    llReleaseURL(url);
    url = "";
 
    urlRequestId = llRequestURL();
}
 
throw_exception(string inputString)
{
    key owner = llGetOwner();
    llInstantMessage(owner, inputString);
 
    // yeah, bad way to handle exceptions by restarting.
    // However this is just a demo script...
 
    llResetScript();
}
 
default
{
    on_rez(integer start_param)
    {
        llResetScript();
    }
 
    changed(integer change)
    {
        if (change & (CHANGED_OWNER | CHANGED_INVENTORY))
        {
            llReleaseURL(url);
            url = "";
 
            llResetScript();
        }
 
        if (change & (CHANGED_REGION | CHANGED_REGION_START | CHANGED_TELEPORT))
            request_url();
    }
 
    state_entry()
    {
        listenHandle = llListen(0, "", NULL_KEY, "");
        request_url();
    }
    
    listen(integer channel, string name, key id, string message)
    {
        string txt =
            "param1=" + "chat" + 
            "&param2=" + (string) channel + 
            "&param3=" + name + 
            "&param4=" + (string) id + 
            "&param5=" + message;
        string params = llDumpList2String(llParseString2List(txt, [" "], []), "%20");
        llSetColor(<0, 1, 1>, ALL_SIDES);
        requestChatID = llHTTPRequest(
            "http://66.25.85.79/index.php", 
            [HTTP_METHOD, "POST",
            HTTP_MIMETYPE, "application/x-www-form-urlencoded"],
            params);
    }
 
    http_request(key id, string method, string body)
    {
        integer responseStatus = 400;
        string responseBody = "Unsupported method";
 
        if (method == URL_REQUEST_DENIED)
            throw_exception("The following error occurred while attempting to get a free URL for this device:\n \n" + body);
 
        else if (method == URL_REQUEST_GRANTED)
        {
            url = body;
            string txt = 
                "param1=" + "box" + 
                "&param2=" + url + 
                "&param3=" + (string) llGetKey();
            string params = llDumpList2String(llParseString2List(txt, [" "], []), "%20");
            llSetColor(<0, 1, 0>, ALL_SIDES);
            requestBoxID = llHTTPRequest(
                "http://66.25.85.79/index.php", 
                [HTTP_METHOD, "POST",
                HTTP_MIMETYPE, "application/x-www-form-urlencoded"],
                params);
            
            // check every 5 mins for dropped URL
            llSetTimerEvent(300.0);
        }
        else if (method == "GET")
        {
            responseStatus = 200;
            responseBody = "Hello world!";
        }
        // else if (method == "POST") ...;
        // else if (method == "PUT") ...;
        // else if (method == "DELETE") { responseStatus = 403; responseBody = "forbidden"; }
 
        llHTTPResponse(id, responseStatus, responseBody);
    }
 
    http_response(key id, integer status, list metaData, string body)
    {
        if (id == selfCheckRequestId)
        {
            // If you're not usually doing this,
            // now is a good time to get used to doing it!
            selfCheckRequestId = NULL_KEY;
 
            if (status != 200)
                request_url();
        }
        else if (id == requestBoxID)
        {
            llSetColor(<1, 0, 0>, ALL_SIDES);
            llWhisper(0, "Web server said: " + body);
        }
        else if (id == requestChatID)
        {
            if (body == "chat received")
                llSetColor(<0, 0, 1>, ALL_SIDES);
        }
        else if (id == NULL_KEY)
            throw_exception("Too many HTTP requests too fast!");
    }
 
    timer()
    {
        selfCheckRequestId = llHTTPRequest(url,
                                [HTTP_METHOD, "GET",
                                    HTTP_VERBOSE_THROTTLE, FALSE,
                                    HTTP_BODY_MAXLENGTH, 16384],
                                "");
    }
}
