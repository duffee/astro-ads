# Project Requirements

In summary, we need to be able to:
search for papers,
find citations/references for a paper,

## Guidelines

* Minimal dependancies, need to be as easy to install as possible.

## Search

* search for papers
** what kind of search terms?
*** author
*** phrase in abstract, title
*** year
*** phrase in body
*** phrase in full record
*** by publication (ApJ)
*** object
** compound search queries

* restrict search by properties (refereed papers only)
* data links
* document type
* select ADS mirror (follow up queries to same place with class variable)
* handle & in bibcodes and other funny characters

### Follow on queries

* citations
* references

## Results

* handle paging
* sorting (relevancy, publication date, citation count, recent reads)
* data links
* full text source
* article view
* add/remove paper to Results object

### Export results

* BibTeX format for reporting search results

## Paper

* print out summary (XML or Text, selected fields)
* object to hold and report all the metadata


## Utilities and Module Behaviour

* commandline script to query ADS (adsquery.pl)
* pick up HTTP_PROXY or add proxy() method
* use the API key in ~/.ads/dev_key or ADS_DEV_KEY
* set timeout with timeout()
* handle network outages
* access to the user agent

## Stretch goals

* followup queries (or whatever they've become)
* smart searches (trending, useful, reviews, TopN)
* positional search
* solr fields and operators
* ADS libraries
* [ORCID interface](https://metacpan.org/pod/WWW::ORCID)
