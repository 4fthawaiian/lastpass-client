lastpass-client
===============

At my previous job, we had a cool ruby script that acted as client/server for PasswordManagerPro. I missed it, so I decided to rewrite it, but without the dependency on the massively expensive, proprietary software package. I give you, lastpass-client (sexy name, right?). It's a very early alpha, but it suits my purposes for the moment.

Features: Not a lot. You run the script with no arguments to start the server, and then run the script with 1 argument, which the script uses to query the server. It currently returns the best match for the string you send, so it's best to give it as specific a name as possible.

Install:

<pre>

echo "username=MYLASTPASSUSERNAME" >> ~/.lprc

echo "password=MYLASTPASSPASSWORD" >> ~/.lprc

git clone git@github.com:4fthawaiian/lastpass-client.git

lastpass-client/lp.rb & # starts the server

lastpass-client/lp.rb NAME_OF_RESOURCE_YOU_WANT

</pre>

No warranty provided that this won't completely b0rk your lastpass repo. You've been warned.
