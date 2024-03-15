WITH '
PREFIX neo: <neo://voc#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

CONSTRUCT {
  # Basic labels for items and their parents
  ?item neo:label ?itemLabel .
  ?parentItem neo:label ?parentItemLabel .
  ?parentItem2 neo:label ?parentItem2Label .
  
  # Direct parent relationship
  ?item neo:HAS_PARENT ?parentItem .
  
  # Second-level parent relationship
  ?parentItem neo:HAS_PARENT ?parentItem2 .
  
  # Dynamically constructed equivalence links for similar entities
  ?item neo:SAME_AS ?similarItem .

  # URL for each item
  ?item neo:url ?itemUrl .
}

# DIVIDE THE QUERY INTO MULTIPULE PARTS OTHERWISE WIKIDATA WILL NOT ACCEPT IT
WHERE {
  VALUES ?item { wd:Q64116 wd:Q4983472 wd:Q121769 wd:Q15054211 wd:Q8034980}
                wd:Q35054 wd:Q7994771 wd:Q7138337 wd:Q19695 wd:Q684 wd:Q2716414 wd:Q2844026
                wd:Q604525 wd:Q41726 wd:Q1580236 wd:Q1330508 wd:Q7075 wd:Q269412 wd:Q6979672
                wd:Q79990 wd:Q3914 wd:Q659 wd:Q34217 wd:Q83278 wd:Q83149 wd:Q65088676
                wd:Q5172236 wd:Q280856 wd:Q1423785 wd:Q1807596 wd:Q3309308 wd:Q685005
                wd:Q21933817 wd:Q9439 wd:Q16406 wd:Q5888904 wd:Q1781097 wd:Q25550691
                wd:Q8039639 wd:Q12823105 wd:Q3400528 wd:Q5666591 wd:Q4804416 wd:Q194297
                wd:Q108325 wd:Q38984 wd:Q19686 wd:Q4958522 wd:Q42049 wd:Q209714 wd:Q2086195
                wd:Q8039641 wd:Q228494 wd:Q1541030 wd:Q7974617 wd:Q361 wd:Q331357 wd:Q397
                wd:Q2182993 wd:Q215112 wd:Q38076 wd:Q190464 wd:Q6123139 wd:Q1053973
                wd:Q134624 wd:Q317557 wd:Q5478606 wd:Q7497928 wd:Q7427481 wd:Q2926113 
                wd:Q8063 wd:Q7860202 wd:Q1637680 wd:Q3364526 wd:Q12014132 wd:Q2366839
                wd:Q5195043 wd:Q2409230 wd:Q245343 wd:Q487494 wd:Q35525 wd:Q470188 
                wd:Q1583868 wd:Q12770 wd:Q489438 wd:Q102728 wd:Q12892 wd:Q6608454
                wd:Q7083471 wd:Q5469236 wd:Q23090 wd:Q4877059 wd:Q7514165 wd:Q5439196 
                wd:Q14659 wd:Q1621811 wd:Q812906 wd:Q1922815 wd:Q81279 wd:Q7406600 
                wd:Q5098235 wd:Q206988 wd:Q170497 wd:Q8004294 wd:Q5298588 wd:Q244457 
                wd:Q246655 wd:Q63302141 wd:Q509364 wd:Q3414013 wd:Q2141800 wd:Q423044 
                wd:Q1893576 wd:Q1090880 wd:Q118046 wd:Q15732645 wd:Q5161738 wd:Q27477249
                wd:Q8039649 wd:Q607241 wd:Q4999736 wd:Q149716 wd:Q7374229 wd:Q2059003
#### PART 1 ####
                wd:Q238803 wd:Q747336 wd:Q4660971 wd:Q508998 wd:Q837142 wd:Q7504315 
                wd:Q8039643 wd:Q34 wd:Q157963 wd:Q74707 wd:Q7201616 wd:Q13648885 
                wd:Q5511914 wd:Q4166034 wd:Q958479 wd:Q1548712 wd:Q1295201 wd:Q221275 
                wd:Q7299331 wd:Q967098 wd:Q210278 wd:Q5302681 wd:Q21449937 wd:Q575759
                wd:Q874407 wd:Q4799132 wd:Q4999737 wd:Q128015 wd:Q3373231 wd:Q20165 
                wd:Q17051533 wd:Q215293 wd:Q176483 wd:Q14745 wd:Q7364486 wd:Q4788543 
                wd:Q1430789 wd:Q5271242 wd:Q1544592 wd:Q1645474 wd:Q362 wd:Q11114344
                wd:Q781156 wd:Q667 wd:Q184163 wd:Q477683 wd:Q5139499 wd:Q104871 wd:Q1772582
                wd:Q1798773 wd:Q20176598 wd:Q28853720 wd:Q59187 wd:Q3066164 wd:Q1571336 wd:Q545719
                wd:Q16211181 wd:Q15241659 wd:Q3434931 wd:Q5002578 wd:Q5522627 wd:Q4948446 wd:Q739384
                wd:Q10633 wd:Q5767753 wd:Q6153237 wd:Q213474 wd:Q6302726 wd:Q7382384 wd:Q980649
                wd:Q37073 wd:Q11399 wd:Q779419 wd:Q7982 wd:Q6569929 wd:Q622365 wd:Q1151273 wd:Q154008 
                wd:Q674564 wd:Q3246464 wd:Q5757920 wd:Q152245 wd:Q7721 wd:Q202902 wd:Q2104233 wd:Q34372744 
                wd:Q5504468 wd:Q191578 wd:Q664609 wd:Q5385215 wd:Q551426 wd:Q7242090 wd:Q2740404 wd:Q2390066
                wd:Q2201590 wd:Q7807658 wd:Q2715005 wd:Q17145326 wd:Q826561 wd:Q163 wd:Q337493 wd:Q31948 wd:Q1019361
                wd:Q9682 wd:Q36192 wd:Q336 wd:Q1817504 wd:Q1880581 wd:Q917851 wd:Q673873 wd:Q3336928 wd:Q239849
                wd:Q5599395 wd:Q7581575 wd:Q671595 wd:Q548588 wd:Q2527930 wd:Q2698460 wd:Q2012769 wd:Q15228761 wd:Q2729831 
                wd:Q457092 wd:Q82006 wd:Q2569184 wd:Q3079423 wd:Q1091544 wd:Q1027124 wd:Q2740409 wd:Q638216 wd:Q479179
#### PART 2 ####
                wd:Q82708 wd:Q5933291 wd:Q7998743 wd:Q2568545 wd:Q6964867 wd:Q128985 wd:Q4894863 wd:Q8039647 wd:Q4894865
                wd:Q1062789 wd:Q6411105 wd:Q8039645 wd:Q48953 wd:Q18571 wd:Q990253 wd:Q984769 wd:Q2141130 wd:Q5928459
                wd:Q201759 wd:Q22 wd:Q7153810 wd:Q216658 wd:Q7817865 wd:Q3309588 wd:Q180516 wd:Q464955 wd:Q28083137
                wd:Q1041481 wd:Q1062856 wd:Q1195942 wd:Q16970 wd:Q3257534 wd:Q5983002 wd:Q7308913 wd:Q4859385
                wd:Q171558 wd:Q5025375 wd:Q7364392 wd:Q6258406 wd:Q713705 wd:Q1129607 wd:Q722793 wd:Q11036
                wd:Q5070802 wd:Q5386901 wd:Q3052933 wd:Q128424 wd:Q4649214 wd:Q1981760 wd:Q3968865 wd:Q54124
                wd:Q21507974 wd:Q27892443 wd:Q847075 wd:Q179904 wd:Q16058687 wd:Q1550874 wd:Q3173323 wd:Q1195346
                wd:Q16867361 wd:Q161238 wd:Q2573220 wd:Q17986734 wd:Q33506 wd:Q23169 wd:Q2198537 wd:Q1308100
                wd:Q33817 wd:Q160894 wd:Q561142 wd:Q386302 wd:Q15030047 wd:Q185968 wd:Q339307 wd:Q193651
                wd:Q9129 wd:Q21196 wd:Q2899400 wd:Q28406532 wd:Q7590517 wd:Q676318 wd:Q939871 wd:Q831768
                wd:Q51870086 wd:Q200538 wd:Q363671 wd:Q2308772 wd:Q5393818 wd:Q6551527 wd:Q4950574
                wd:Q5591390 wd:Q4321471 wd:Q7298285 wd:Q16115844 wd:Q21063317 wd:Q374614 wd:Q142035
                wd:Q1947144 wd:Q11773045 wd:Q183 wd:Q34038 wd:Q219760 wd:Q1137767 wd:Q6934907 wd:Q5025454
                wd:Q14935158 wd:Q313702 wd:Q2538997 wd:Q2469078 wd:Q4649008 wd:Q1535858 wd:Q7553928
                wd:Q4922065 wd:Q5111407 wd:Q524757 wd:Q28407037 wd:Q2439962 wd:Q203995 wd:Q7731063
                wd:Q5594123 wd:Q367885 wd:Q1925344 wd:Q743001 wd:Q14420 wd:Q333791 wd:Q1060822
                wd:Q249565 wd:Q16951939 wd:Q569500 wd:Q7275268 wd:Q2884709 wd:Q3797766 wd:Q2513247
#### PART 3 ####
                wd:Q5656763 wd:Q4837006 wd:Q211907 wd:Q5472968 wd:Q12099 wd:Q131087 wd:Q8016
                wd:Q84 wd:Q3222002 wd:Q1769761 wd:Q5504247 wd:Q1740301 wd:Q728522 wd:Q1501 wd:Q7816289
                wd:Q99864 wd:Q7115609 wd:Q2609672 wd:Q750752 wd:Q16775410 wd:Q200334 wd:Q7761917
                wd:Q1524274 wd:Q438200 wd:Q16917 wd:Q11707 wd:Q7920419 wd:Q5877264 wd:Q1070192 
                wd:Q267941 wd:Q2798656 wd:Q6516066 wd:Q3398786 wd:Q938290 wd:Q2531974 wd:Q19879795 wd:Q1325334
                wd:Q454635 wd:Q7284185 wd:Q699370 wd:Q11789420 wd:Q22662509 wd:Q918396 wd:Q7178 wd:Q24705882
                wd:Q16870609 wd:Q7140005 wd:Q406633 wd:Q5190452 wd:Q5124342 wd:Q2962239 wd:Q2452067 wd:Q2675191
                wd:Q7131357 wd:Q15548045 wd:Q2438674 wd:Q1832636 wd:Q2663784 wd:Q5599538 wd:Q302613 wd:Q494829
                wd:Q2598 wd:Q16062845 wd:Q919431 wd:Q1421600 wd:Q81727 wd:Q920355 wd:Q6663436 wd:Q19849 
                wd:Q4898254 wd:Q6451898 wd:Q7754897 wd:Q4859210 wd:Q2900243 wd:Q20998540 wd:Q7562354 wd:Q26426014
                wd:Q948878 wd:Q5326207 wd:Q804402 wd:Q48438 wd:Q2707376 wd:Q725671 wd:Q15263395 wd:Q182688
#### PART 4 ####
                wd:Q5757457 wd:Q8022857 wd:Q1989093 wd:Q7280993 wd:Q6939550 wd:Q661513 wd:Q5128902 wd:Q1893282
                wd:Q1359589 wd:Q258 wd:Q1914884 wd:Q2176995 wd:Q289 wd:Q5648787 wd:Q7984057 wd:Q575 wd:Q7439853
                wd:Q7848198 wd:Q7814332 wd:Q750841 wd:Q152096 wd:Q93191 wd:Q7143609 wd:Q2094727 wd:Q769691
                wd:Q4983475 wd:Q7569 wd:Q1208163 wd:Q448403 wd:Q4925856 wd:Q5116634 wd:Q929928 wd:Q133792
                wd:Q7374822 wd:Q117202 wd:Q2740021 wd:Q2476957 wd:Q409721 wd:Q1900271 wd:Q47128 wd:Q2820825 
                wd:Q3309464 wd:Q3494229 wd:Q7648508 wd:Q1139213 wd:Q503354 wd:Q188307 wd:Q15633792 wd:Q994112
                wd:Q1838917 wd:Q965321 wd:Q2109493 wd:Q1152847 wd:Q1059869 wd:Q3109696 wd:Q7374405 wd:Q4641858
                wd:Q44294 wd:Q22889 wd:Q20875 wd:Q6771990 wd:Q676555 wd:Q450914 wd:Q3098650 wd:Q122553
                wd:Q17035329 wd:Q2259685 wd:Q7698610 wd:Q991253 wd:Q1783168 wd:Q5647717 wd:Q126701 wd:Q23018607
                wd:Q7721758 wd:Q6777191 }
 

  # Fetch labels in English
  ?item rdfs:label ?itemLabel . FILTER(LANG(?itemLabel) = "en")
  
  # First-level parent
  OPTIONAL {
    ?item wdt:P31|wdt:P279 ?parentItem .
    ?parentItem rdfs:label ?parentItemLabel . FILTER(LANG(?parentItemLabel) = "en")
    
    # Second-level parent
    OPTIONAL {
      ?parentItem wdt:P31|wdt:P279 ?parentItem2 .
      ?parentItem2 rdfs:label ?parentItem2Label . FILTER(LANG(?parentItem2Label) = "en")
    }
  }
  
  # Matching similar entities based on some criteria (example shown with owl:sameAs)
  OPTIONAL {
    ?item owl:sameAs ?similarItem .
  }
}
' AS query
// Calls the n10s.rdf.import.fetch procedure to import RDF data into Neo4j
CALL n10s.rdf.import.fetch(
    // Constructs the URL for the SPARQL endpoint, including the query part.
    // The `query` variable should contain your SPARQL query string.
    // apoc.text.urlencode ensures that the query string is URL-encoded.
    'https://query.wikidata.org/sparql?query='+ apoc.text.urlencode(query),
    
    // Specifies the format of the RDF data to be imported ("N-Triples").
    "N-Triples",
    
    // Sets the HTTP header to accept plain text, which is the format for N-Triples.
    {headerParams: {Accept :"text/plain"}}
)
// Yields results from the import process, including status and statistics.
YIELD terminationStatus, triplesLoaded, triplesParsed, namespaces, extraInfo

// Returns the results of the import operation.
RETURN terminationStatus, triplesLoaded, triplesParsed, namespaces, extraInfo
