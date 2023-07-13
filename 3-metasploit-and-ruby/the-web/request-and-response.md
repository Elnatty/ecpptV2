# Request and Response

We will be utilising the `Net::HTTP` library for this.

`>> resp = Net::HTTP.get_print(URI("http://localhost/"))` - We use the get\_print method to output the entire web html result on the screen.

`>> resp = Net::HTTP.get_response(URI("http://localhost/"))`&#x20;

{% code overflow="wrap" lineNumbers="true" %}
```ruby
# Retrieving all the response information.
# Response Header.
>> resp = Net::HTTP.get_response(URI("http://localhost/")) response object.
>> resp_obj.code # returns statuscode "200".
>> resp_obj.message # returns if "OK".
>> resp_obj.class.name # returns if "Net::HTTPOK".
>> resp_obj.to_hash # returns the header information

# Response Body
>> resp_obj.body # returns the body content.
```
{% endcode %}

## HTML Parser \[nokogiri]

[https://nokogiri.org/#parsing-and-querying](https://nokogiri.org/#parsing-and-querying)

{% code overflow="wrap" lineNumbers="true" %}
```ruby
>> require 'open-uri'
>> doc = Nokogiri::HTML(URI.open("http://localhost"))
>> doc # prints the whole page in a tree format.
>> puts doc.serialize # turns the serialize the tree into an html stream.
>> doc.title # outputs page title.
>> doc.children # prints all the children.
>> doc.search("div.contentbox") # search using css selectors.
```
{% endcode %}



