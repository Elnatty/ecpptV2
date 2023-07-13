# The Web

### Using TCPSocket to get http resources/files

We can use the default apache2 web server in kali to test.

`service apache2 start` - starts the server. type "localhost" in browser to access the webpage.

We are going to use TCPSocket to do same thing.

{% code overflow="wrap" lineNumbers="true" %}
```ruby
>> require 'socket' # require the socket library 1st.
>> s = TCPSocket.new('localhost',80)
>> request = "GET /HTTP/1.0\r\n\r\n" # get request.
>> s.print(request)
>> response = s.read # outputs the response.
>> headers,body = response.split("\r\n\r\n") # you can split headers and body to analyze them separately.
```
{% endcode %}

Instead We can use the `Net::HTTP` library to interact with web servers in a more structured way.

### Using Net::HTTP library

{% code overflow="wrap" lineNumbers="true" %}
```ruby
>> require 'net/http'
>> resonse = Net::HTTP.get("localhost","/")
>> print response # prints the full web html.
```
{% endcode %}

### Using Open-uri library

[https://docs.ruby-lang.org/en/master/OpenURI.html](https://docs.ruby-lang.org/en/master/OpenURI.html)

{% code overflow="wrap" lineNumbers="true" %}
```ruby
>> require 'open-uri'
>> URI.open("http://localhost/") do |http|
 puts http.read # outputs entire web html.
end
```
{% endcode %}
