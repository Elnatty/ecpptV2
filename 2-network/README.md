# 2 - Network

### Google Dorking

* `intitle:"index of" Super Girl` - searches for the movie Super Girl.
* `cache:techfashy.com` - google cache of a website.
* `elearnsecurity filetype:pdf` - get pdf files.
* `site:exploitdb.com`&#x20;
* `site:elearnsecurity.com and filetype:pdf`

## Local File Inclusion

```
inurl:"?page=news.php"
inurl:"index.php?main=*php"
inurl:"index.php?inc=*php"
inurl:"index.php?pg=*php"
inurl:"index.php?include_file=*php"
inurl:"index.php?main=*html"
inurl:"index.php?inc=*html"
inurl:"index.php?pg=*html
inurl:index.php?id=
inurl:index.php?cat=
inurl:index.php?action=
inurl:index.php?content=
inurl:index.php?page=
```

<figure><img src="../.gitbook/assets/image (37).png" alt=""><figcaption></figcaption></figure>

### Additional Search Engines

* Crunchbase ([https://www.crunchbase.com/discover/organization.companies](https://www.crunchbase.com/discover/organization.companies)) --> GoldMine.
* Bing
* peoplesfinder
* truthfinder
* pipl.com
* archive.org (archived/cached websites).
* Indeed (Glassdoor, SimplyHired, Dice, other job sites).
* Social media (linkedin) etc.
* Yahoo
* Ask
* Aol
* Pandastats.net
* Dogpile.com

### Harvesting info from Open source

* FOCA (for windows only): allows us search for usernames, files, passws, OS, ip addr, metadata and download them automatically. for further investigation.
* theHarvester.

### References:

{% embed url="https://www.googleguide.com/advanced_operators_reference.html" %}

