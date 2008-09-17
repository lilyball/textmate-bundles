//var sUniqueCounter = 0;
var sSendCommands = true;      // if false, makes sendSyndicationCmd a no-op unless reloadArticles is set

var sReadClass            = "apple-rss-article apple-rss-read";
var sUnreadClass          = "apple-rss-article apple-rss-unread";
var sSelectedClass        = "apple-rss-selected";
var sBookmarkedClass      = "apple-rss-bookmarked";
var sCurrentClass         = "apple-rss-current";

var sCountsId             = "apple-rss-counts";
var sTotalCountId         = "apple-rss-total-count"; // The visible total count
var sTotalArticleCountId  = "apple-rss-total-article-count"; // A span that can arrive on reload with new counts
var sUnreadCountWrapperId = "apple-rss-unread-count-wrapper";
var sUnreadCountId        = "apple-rss-unread-count";
var sAlertBannerId        = "apple-rss-alert-banner";
var sAlertUrlId           = "apple-rss-alert-url";
var sAlertTextId          = "apple-rss-alert-text";
var sAlertPasswordFormId  = "apple-rss-alert-form";

var sBookmarkLinkId       = "apple-rss-bookmark-link";
var sBookmarkHrefId       = "apple-rss-bookmark-href";
var sSearchfieldId        = "apple-rss-search-field";
var sTunesLinkId          = "apple-rss-itunes-link";
var sTimespansId          = "apple-rss-timespans";
var sSourcelistId         = "apple-rss-source-list";

var sInfoId               = "AppleSyndicationInfo"; // Do not change this without ensuring a commensurate change is made in the browser
var sContentId            = "apple-rss-content";
var sSliderId             = "apple-rss-slider";
var sScrollerId           = "apple-rss-scroller";
var sSidebarId            = "apple-rss-sidebar";
var sSortsId              = "apple-rss-sorts";
var sNoArticlesId         = "apple-rss-no-articles";

var sCurrentArticlesId    = "apple-rss-current-articles";
var sPaginationId         = "apple-rss-pagination";
var sNextArticlesId       = "apple-rss-next-articles";
var sNextArticleId        = "apple-rss-next-article";
var sPreviousArticlesId   = "apple-rss-previous-articles";
var sPreviousArticleId    = "apple-rss-previous-article";

var sTitleTextId          = "apple-rss-title-text";
var sSourceNameTextId     = "apple-rss-source-name-text";
var sFOAFPlaceholderId    = "apple-rss-foaf-placeholder";

var sIconLinkId           = "apple-rss-icon";


// Track all of the unread articles we have seen,
// so we can render them as unread in subsequent database round trips
var sUnreadIds = new Array();

// The following are controlled via user defaults and set from Feed.html template
var sMinFirstDate;
var sMaxLastDate;
var sClickToMarkRead;


function requestForSyndicationCmd( cmd, arg, async )
{
	if( async == undefined ) reloadArticles = true;
    var url = document.location.protocol+"//"+document.location.hostname;
    var port = document.location.port;
    if ( port!=null )
        url += ":"+port;
    url += "/__cmd__/"+cmd;
    if( arg != null )
        url += "/"+arg; 
    //url += "/"+(++sUniqueCounter);

    var post = new XMLHttpRequest();
    post.open("POST",url,async);
    post.setRequestHeader("Feed-URL",document.URL);
    return post;
}

function sendSyndicationCmd( cmd, arg, reloadArticles, async )
{
    if( reloadArticles == undefined ) reloadArticles = false;
    if( sSendCommands || reloadArticles ) {
        var post = requestForSyndicationCmd(cmd,arg,async);
        if( reloadArticles ) {

            post.setRequestHeader("Return-Articles","true");
            post.setRequestHeader("Filter-String", sIsPaginated && sFilterString ? sFilterString : "");
            post.onload = function( ) {reloadArticlesFromHTML(post.responseText);}
        }
        post.send(null);
//console.log("sent cmd "+cmd+" reload "+reloadArticles);
    }
}


//// SEPARATORS

function isArticleDiv(div) {
	return (div.className == sUnreadClass || div.className == sReadClass);
}


function getPreviousArticleDiv( div ) {
	while (div = div.previousSibling) { if (isArticleDiv(div)) break; }
	return div;
}


function getNextArticleDiv( div ) {
	while (div = div.nextSibling) { if (isArticleDiv(div)) break; }
	return div
}


function getNextReadArticleDiv( div ) {
	while (div = div.nextSibling) { if (div.className == sReadClass) break; }
	return div	
}


function showHideSeparator(articleDivWithSeparator, nextArticleDiv) {
	if (!articleDivWithSeparator) return;

	var isRead   = (articleDivWithSeparator.className == sReadClass);
	var nextRead = (!nextArticleDiv || nextArticleDiv.className == sReadClass);

	if (isRead && nextRead) {
		articleDivWithSeparator.setAttribute("showSeparator", "true");
	} else {
		articleDivWithSeparator.removeAttribute("showSeparator");
	}
}


//// MARK AS READ

function handleArticleClick( articleDiv )
{
	markArticlesRead( [ articleDiv ] );    	

	sUnreadCount--;
	redisplayCounts();

	// Only send synchronously if we are about to leave the page.  If the user just clicked on the div, go async
	var sourceElement = window.event.srcElement;
	var areWeLeavingPage = (sourceElement.nodeName.toUpperCase() == "A") && (sourceElement.href != undefined);
	var sendAsynchronously = (areWeLeavingPage == false);

	if (sClickToMarkRead) {
		sendSyndicationCmd("markRead", articleDiv.getAttribute("articleid"), false, sendAsynchronously);
	}

    window.event.cancelBubble = true; // Prevent parent element from handling click
    return true;
}


function markAllRead( )
{
    // Scan DOM for visible unread articles; make each display as read
	var articleDivs = new Array();
	var articleIds  = new Array();
    var parent = document.getElementById(sContentId);
    var children = parent.childNodes;

	var n = children.length;
    for( var i = 0; i < n; i++ ) {
        var articleDiv = children[i];

        if( articleDiv.nodeType == 1 && articleDiv.className == sUnreadClass ) {
            articleDivs.push(articleDiv);
			articleIds.push(articleDiv.getAttribute("articleid"));
        }
    }

	markArticlesRead(articleDivs);

	sUnreadCount = 0;
	redisplayCounts();

	sendSyndicationCmd("markAllRead", "", false);
}


function markArticlesRead( articleDivs ) {
	for( var i in articleDivs ) {
		articleDiv = articleDivs[i]
		articleDiv.className = sReadClass;
		
		var previousArticleDiv = getPreviousArticleDiv(articleDiv);
		var nextArticleDiv = getNextArticleDiv(articleDiv);

		showHideSeparator(previousArticleDiv, articleDiv);
		showHideSeparator(articleDiv, nextArticleDiv);	
	}
}


//// FILTERING

var sFilterField;
var sPrefiltered;                   // true if content has been prefiltered
var sFilterString;                  // current filter string. Do not set directly; call setFilterString
var sFilterMatcher;                 // WordMatcher for words in sFilterString.  Do not set directly; call setFilterString
var sFilterWords;                   // Fallback to JavsScript word matcher until native implementations ready
var sUsesBasicFiltering;            // Set to true if we're going to filter in JS entirely, versus using one of our native implementations
var sFirstDate, sLastDate;          // date range currently being shown (these are STRINGS)
var sSourceFilter;                  // index of source being displayed, null for all (STRINGS)
var sSourceUUID;

function setFilterString( filterString ) {
    sUsesBasicFiltering = true;
    sFilterString = sFilterMatcher = null;
    sFilterWords = new Array();
    if( filterString ) {
        filterString = filterString.toLocaleLowerCase();
        var words = (filterString+" ").match(/(\S+)(?=\s)/g);
        if( words ) {
            try {
                // First try creating a PubSubWordMatcher object
                sFilterMatcher = new PubSubWordMatcher(words);
                sUsesBasicFiltering = false;
            } catch (e) {
                // If that fails, we need to use the other types of word matching available to us
            }
            if( !sFilterMatcher ) {
                if( window.pubsub ) {
                    // If the window.pubsub object is available, use it
                    sFilterWords = window.pubsub.createWordMatcher(words);
                    sUsesBasicFiltering = false;
                } else {
                    // Otherwise, fall back to basic filtering, done directly in this Javascript
                    sFilterWords = words;
                }
            }
            sFilterString = filterString;
        }
    }
}

function setupFilter( )
{
    sFilterField = document.getElementById(sSearchfieldId);
    sFilterField.focus();
    setFilterString(sFilterField.value);
    sPrefiltered = (sFilterString != null);
}

function setURLToBookmark( )
{
    var protocol = document.location.protocol.toLowerCase();
    var url = document.location.href;
    if( protocol == "feeds:" ) {
        var trim = url.indexOf("&filter:");
        if( trim >= 0 )
            url = url.substring(0,trim);
        if( sFilterString )
            url += "&filter:"+encodeURIComponent(sFilterString);
    } else if( protocol = "feed:" ) {
        // Add a filter to a feed: URL by converting it into a single-item feeds:
        if( sFilterString ) {
            url = url.substring(5);
            if( url.indexOf("//")==0 )
                url = url.substring(2);            
            url = "feeds:"+encodeURIComponent(document.title)+"&"
                + url.replace("&","%26")
                + "&filter:"+encodeURIComponent(sFilterString);
        }
    }
    
    // Shove this URL into an attr of a <meta id="AppleSyndicationInfo"> tag.
    // Do not change the id, or the attribute name, without a commensurate change in the browser.
    document.getElementById(sInfoId).setAttribute("URLToBookmark", url);
}

/** This is called by an event handler whenever the search field's content changes */
function setContentFilter( filter, bookmarkLinkTitle, searchLinkTitle )
{
    //var time = (new Date()).getTime();
    
    var oldFilter = sFilterString;
    setFilterString(filter);
    var reload = (sFilterString != oldFilter) && (sPrefiltered || sIsPaginated);

    setURLToBookmark();
    
    if( reload ) {
        // If articles were pre-filtered, we need to load all the articles:
        sPrefiltered = false;
        sResetPagination = true;
        sendSyndicationCmd("refilter",sFilterString,true);
    } else {
//console.log("setContentFilter->refilterArticles()");
        refilterArticles();
    }

    // Show/hide the bookmark link, as appropriate
    var bookmarkLinkDiv = document.getElementById(sBookmarkLinkId);
    var bookmarkLink = document.getElementById(sBookmarkHrefId);   
    if( ! sFilterString ) {
        var bookmarkAttr = bookmarkLinkDiv.getAttribute("class");
        
        // If we've just cleared the filter, and we're already bookmarked, hide the link
        if (bookmarkAttr == sBookmarkedClass) {
            bookmarkLinkDiv.style.display = "none";
        }
        // Otherwise, show Add Bookmark
        else {
            bookmarkLink.innerText = bookmarkLinkTitle;
            bookmarkLinkDiv.style.display = "block";
        }
    } else {
        // If we're adding chars to the filter, show the link with the text "Bookmark This Search"
        bookmarkLink.innerText = searchLinkTitle;
        bookmarkLinkDiv.style.display = "block";
    }
    
    //console.log("Filtering took "+((new Date()).getTime()-time)+" ms");
}


function subscribeInTunes()
{
    var href         = location.href;
    var indexOfColon = href.indexOf(":");

    location.href = "pcast" + href.substr(indexOfColon);    
}

function showAlertBanner(url, alert)
{
    document.getElementById(sAlertUrlId).setAttribute('value', url);
    document.getElementById(sAlertTextId).innerText = alert;
    document.getElementById(sAlertBannerId).style.display = "block";
}

function showAlertPasswordForm()
{
    // The form for entering credentials starts out hidden, and will be displayed
    // if appropriate for the type of error
    document.getElementById(sAlertPasswordFormId).style.display = "block";
}

function showTunesLink()
{
    // Only show the Subscribe in iTunes link if we are displaying a singleton feed
    var protocol = document.location.protocol.toLowerCase();
    if( protocol == "feed:" ) {
        var iTunesLink = document.getElementById(sTunesLinkId);
        iTunesLink.style.display = "block";
    }
}


function refreshFeed()
{
    //! It would be nicer to just ask the agent to check the feeds and send back any new articles
    // and insert them into the DOM. But it's too late for changes like that for Leopard. --jpa 8/2007
    window.location.reload();
}


var sTimespanDivs;


function currentTimespan( )
{
    if( ! sTimespanDivs )
        sTimespanDivs = document.getElementById(sTimespansId).getElementsByTagName("div");
    for( var i=0; i<sTimespanDivs.length; i++ ) {
        var div = sTimespanDivs[i];
        if( div.className == sCurrentClass )
            return parseInt(div.getAttribute("name"));
    }
    return -1;
}

function valOrNull( value )
{
   if( value != null )
	return value;
   else
       return "NULL";
}

/** This is called by an event handler when a date range is clicked */
function setDateFilter( index )
{
    var firstDate=null, lastDate=null;
    
    // Update the styles of the various date links:
    if( ! sTimespanDivs )
        sTimespanDivs = document.getElementById(sTimespansId).getElementsByTagName("div");
    for( var i=0; i<sTimespanDivs.length; i++ ) {
        var div = sTimespanDivs[i];
        var divname = div.getAttribute("name");
        if( divname ) {
            if( parseInt(divname) == index ) {
                div.className = sCurrentClass;
                firstDate = div.getAttribute("firstDate");
                lastDate  = div.getAttribute("lastDate");
            } else {
                div.className = null;
            }
        }
    }
    
    if( firstDate==null || lastDate==null ) {
        //alert("setDateFilter: couldn't get firstDate or lastDate");
        return; // means 'name' was invalid
    }
    if( firstDate=="" ) firstDate = null;
    if( lastDate=="" ) lastDate  = null;
    if( firstDate!=null ) firstDate = parseInt(firstDate);
    if( lastDate!=null ) lastDate = parseInt(lastDate);
    
    // If the articles are paginated or the new range is outside what we have in the HTML, we have to reload.
    // Remember that null means "no limit", which complicates the comparisons.
    var reload = (sIsPaginated || 
                 (sMinFirstDate!=null && (firstDate==null || firstDate < sMinFirstDate))
              || (sMaxLastDate!=null && (lastDate==null || lastDate > sMaxLastDate)));
    //console.log("setDateFilter " + index + " sMinFirstDate " + valOrNull(sMinFirstDate) + " sMaxLastDate " + valOrNull(sMaxLastDate) + " firstDate " + valOrNull(firstDate) + " lastDate " + valOrNull(lastDate));
    //if( reload ) console.log("Must reload HTML");
    sFirstDate = firstDate;
    sLastDate = lastDate;
    
    // Tell the back-end to update the prefs for this feed:
    if( sIsPaginated ) sResetPagination = true;
    sendSyndicationCmd("setTimespan",index,reload);
    
    if( reload ) {
        sMinFirstDate = firstDate;
        sMaxLastDate = lastDate;
    } else {
        // Now refilter, if we already have the HTML:
        refilterArticles();
    }
}


var sSourceDivs;


function currentSourceFilter( ) // returns uuid
{
    if( ! sSourceDivs )
        sSourceDivs = document.getElementById(sSourcelistId).getElementsByTagName("div");
    for( var i=0; i<sSourceDivs.length; i++ ) {
        var div = sSourceDivs[i];
        if( div.className == sCurrentClass )
            return div.getAttribute("uuid");
    }
    return "";
}


var sOriginallySourceFiltered;


/** This is called by an event handler when a source is clicked */
function setSourceFilter( uuid )
{
    var which = "-1";
    
    // Update the styles of the various source links:
    if( ! sSourceDivs )
        sSourceDivs = document.getElementById(sSourcelistId).getElementsByTagName("div");
    for( var i=0; i<sSourceDivs.length; i++ ) {
        var div = sSourceDivs[i];
        var divuuid = div.getAttribute("uuid");
        if( divuuid != undefined ) {
            if( sOriginallySourceFiltered === undefined ) {
                if( div.className == sCurrentClass )
                    sOriginallySourceFiltered = (divuuid != "");
            }
            if( divuuid == uuid ) {
                div.className = sCurrentClass;
                which = div.getAttribute("name");
            } else {
                div.className = null;
            }
        }
    }
    
    sSourceFilter = (which=="-1" ?null :which);
    if( sIsPaginated || sOriginallySourceFiltered ) {
        sSourceUUID = uuid; 
        sResetPagination = true;
    } else {
        sSourceUUID = "";
        refilterArticles();
    }
    sendSyndicationCmd("setSource",uuid,(sIsPaginated || sOriginallySourceFiltered));
}

// Various counts
var sTotalArticleCount=0; // Total articles in all pages (or just in this page if !sIsPaginated)
var sUnreadCount=0;

function shouldShowArticle( article )
{
    var articleDate = article.getAttribute("articlesortdate");
    if( articleDate ) {
        if( !sIsPaginated ) {
            if( sFirstDate && articleDate < sFirstDate )
                return false;
            if( sLastDate && articleDate >= sLastDate )
                return false;
            if( sSourceUUID == "" && sSourceFilter && sSourceFilter != article.getAttribute("sourceindex") )
                return false;
            if( ! articleMatchesFilter(article) )
                return false;
        }
        sTotalArticleCount++;
        if( article.className == sUnreadClass )
            sUnreadCount++;
    }
    return true;
}

var sTotalCountSpan, sUnreadCountSpan, sUnreadCountWrapperSpan;

function updateNoArticlesMessage( )
{
    // Show the "No Articles" message if there are no visible articles:
    var noarticles = document.getElementById(sNoArticlesId);

    // This can be executed before the page has finished loading, and this element isn't present yet
    if( noarticles ) {
        if( sTotalArticleCount == 0 ) {
            // Look up message to display, from attr of selected timespan div:
            var message = null;
            var divs = document.getElementById(sTimespansId).getElementsByTagName("div");
            for( var i=0; i<divs.length; i++ ) {
                var div = divs[i];
                if( div.className == sCurrentClass ) {
                    message = div.getAttribute("noarticles");
                    break;
                }
            }
            if( message )
                noarticles.innerText = message;
            noarticles.style.display = "block";
        } else {
            noarticles.style.display = "none";
        }
    }
}

var sCountsDiv;

function redisplayCounts( )
{
//console.log("redisplayCounts() total " + sTotalArticleCount + " unread " + sUnreadCount);
    if (sCountsDiv == undefined) {
        sCountsDiv = document.getElementById(sCountsId);
        sCountsDiv.style.display = "block"; // now show counts
    }
    
    if( sTotalCountSpan == undefined )
        sTotalCountSpan = document.getElementById(sTotalCountId);
    sTotalCountSpan.innerText = "" + (sTotalArticleCount);  
    
    if( sUnreadCountWrapperSpan == undefined )
        sUnreadCountWrapperSpan = document.getElementById(sUnreadCountWrapperId);
    sUnreadCountWrapperSpan.style.display = (sUnreadCount>0 ?"inline" :"none");
    
    if( sUnreadCountSpan == undefined )
        sUnreadCountSpan = document.getElementById(sUnreadCountId);
    sUnreadCountSpan.innerText = "" + sUnreadCount;
    
    updateNoArticlesMessage();
}

// Used for non-paged aggregates to recalculate filter in JavaScript space
function refilterArticles( )
{
    sTotalArticleCount = sUnreadCount = 0;
    var articles = document.getElementById(sContentId).childNodes;
    var articleToKeepInView;
//console.log("refilterArticles() filtering "+articles.length);
    var divsEvaluated = 0;
    for( var i=0; i<articles.length; i++ ) {
        var article = articles[i];
        if( article.nodeName == 'DIV' ) {
			divsEvaluated++;
		    if( shouldShowArticle(article) ) {
		        article.style.display = "";
                articleToKeepInView = article;
		    } else {
		        article.style.display = 'none';
		    }
        }
    }
//console.log("refilterArticles() examined "+divsEvaluated);
    redisplayCounts();
    keepArticleInView(articleToKeepInView);    
}

// Used by the initial feed to initialize counts for the first feed
function initializeCounts(totalCount, unreadCount)
{
//console.log("initializeCounts("+totalCount+", "+unreadCount+")");
    sTotalArticleCount = totalCount;
    sUnreadCount = unreadCount;
    redisplayCounts();
}

// Used by the incremental feed loader to increment counts as more entries arrive
function incrementCounts(totalCount, unreadCount)
{
//console.log("incrementCounts("+totalCount+", "+unreadCount+")");
    sTotalArticleCount = sTotalArticleCount + totalCount;
    sUnreadCount = sUnreadCount + unreadCount;
    redisplayCounts();
}


// When an incremental load will overflow a page boundary (or has already)
// it will send a whole page of entries, prefixed with a command to erase
function eraseArticles( )
{
    var content = document.getElementById(sContentId);
    content.innerHTML = "";
}

function reloadArticlesFromHTML( html )
{
//console.log("reloadArticlesFromHTML()"); 
    var content = document.getElementById(sContentId);
    content.innerHTML = html;  // Overwrite the previous content with this just loaded
    if( sResetPagination ) sCurrentArticle = 0;
    if( sSourceFilter==null ) sOriginallySourceFiltered = false;     // now have all sources
    if( !sIsPaginated ) refilterArticles();
    setupSlider();
    scroller.scrollTop = 0;    
    if( sResetPagination ) {
        resetPagination();
        sResetPagination = false;
    }
    reSortArticles();
}


var sSearchRange;

function articleMatchesFilter( article )
{
    //var text = article.innerText;     // <-doesn't work for hidden <div>s, unfortunately
    if( ! sSearchRange ) sSearchRange = document.createRange();
    sSearchRange.selectNodeContents(article);
    text = sSearchRange.toString();

    if( sFilterMatcher ) {
        return sFilterMatcher.match(text);
    } else if ( !sUsesBasicFiltering ) {
        /* Alternative native mechanism */
        return sFilterWords.match(text);
    } else {
        /* Old pure-JS implementation -- keep around only till Safari is updated --jpa 2/1/2005 */
        text = text.toLocaleLowerCase();
        for( var i=sFilterWords.length-1; i>=0; i-- ) {
            var string = sFilterWords[i];
            var start = 0;
            while(true) {
                start = text.indexOf(string,start);
                if( start < 0 )
                    return false;                   // didn't find this string
                if( start==0 )
                    break;                          // found at start of text -- matches
                var prev = text.charAt(start-1);
                if( prev <= '~' ) {
                    if( prev<'0' || (prev>'9' && prev<'a') || prev>'z' )
                        break;                      // found at start of word -- matches
                } else if( prev >= '\u3000' && prev <= '\u303F' ) {
                    break;                          // CJK symbols and punctuation
                } else if( prev >= '\u5000' && prev <= '\u9FFF' ) {
                    break;                          // Chinese/Japanese characters (there are no word breaks)
                } else {
                    // JS regexps don't have a Unicode alphabet char class, only Unicode whitespace.
                    // So we simplistically assume any non-whitespace, with a few exceptions, is alphabetic.
                    if( prev.search(/[\s–—…“”‘’¿¡]/) == 0 )
                        break;                      // found at start of word -- matches
                }
                // This instance wasn't at the start of a word; search for next instance...
                start += string.length;
            }
        }        
        return true;
        /* End of old code */
    }
}


//// SORTING


var sSortDivs;


function currentSort( )
{
    if( ! sSortDivs )
        sSortDivs = document.getElementById(sSortsId).getElementsByTagName("div");
    for( var i=0; i<sSortDivs.length; i++ ) {
        var div = sSortDivs[i];
        if( div.className == sCurrentClass )
            return parseInt(div.getAttribute("name"));
    }
    return 0;
}

var sSortType;
function sortArticlesBy( sortType )
{
    // Update the styles of the various sort links:
    var name = sortType.toString();
//console.log("sortArticlesBy("+name+")");
    if( ! sSortDivs )
        sSortDivs = document.getElementById(sSortsId).getElementsByTagName("div");
    for( var i=0; i<sSortDivs.length; i++ ) {
        var div = sSortDivs[i];
        var divname = div.getAttribute("name");
        if( divname ) {
            if( divname == name )
                div.className = sCurrentClass;
            else
                div.className = null;
        }
    }
    sSortType = sortType;
    if( sIsPaginated ) { // articles are paginated; need to sort all of them
        sResetPagination = true;
        sendSyndicationCmd("setSort",sortType,true);
    } else {
        reSortArticles(sortType);
        sendSyndicationCmd("setSort",sortType);
    }
}


function reSortArticles( )
{
//console.log("reSortArticles()");
    // Make an array of the article nodes, removing other noise from the document:
    var parent = document.getElementById(sContentId);
    var children = parent.childNodes;
    var articles = new Array();
    for( var i=children.length-1; i>=0; i-- ) {
        article = children[i];
        if( article.nodeType == 1 ) // element
	{
	    var id = article.getAttribute("articleid");
	    if( article.className == sUnreadClass ) {
//console.log("unread "+id); 
		if("0"!=id && ""!=id)
		    sUnreadIds[id]=1;
	    } else {
	        // Perhaps we should mark it as unread
		if("0"!=id && ""!=id && sUnreadIds[id])
		{
//console.log("marking unread "+id); 
		     article.className = sUnreadClass;
		}
	    }
            articles.push(article);
	}
        else
            parent.removeChild(article);
    }

    // Sort the article array:
//console.log("reSortArticles(" + sSortType + ")");
    var compareFunc;
    switch(sSortType) {
        case 0: compareFunc = compareDates; break;
        case 1: compareFunc = compareTitles; break;
        case 2: compareFunc = compareSources; break;
        case 3: compareFunc = compareUnread; break;
        default:
            //alert("unknown sortType "+sSortType);
            console.log("Safari RSS: WARNING: unknown sortType "+sSortType);  // If we're leaving a log in, let's label it as ours
            return;
    }
    articles.sort(compareFunc);
        
    // Now put them back:
	var lastDiv = null;
    for( var i=0; i<articles.length; i++ ) {
		var currentDiv = articles[i];
        parent.appendChild(currentDiv);
		showHideSeparator(lastDiv, currentDiv);		
		lastDiv = currentDiv;
    }
	showHideSeparator(lastDiv, null);		
//console.log("reSortArticles() done");
}


function compareDates( a, b )
{
    var adate = a.getAttribute("articlesortdate");
    var bdate = b.getAttribute("articlesortdate");
    if( adate < bdate )
        return 1;                       // We want them in _reverse_ order
    else if( adate == bdate ) {
        var alocal = a.getAttribute("articlelocaldate");
        var blocal = b.getAttribute("articlelocaldate");
        if( alocal < blocal)
            return 1;
        else if( alocal == blocal ) {
            var aid = a.getAttribute("articlesortid");
            var bid = b.getAttribute("articlesortid");
            if( aid < bid )
                return 1;
        }
    }

    return -1;
}


function compareTitles( a, b )
{
    var atitle = a.getAttribute("articlesorttitle");
    var btitle = b.getAttribute("articlesorttitle");
    if( atitle < btitle )
        return -1;
    else if( atitle > btitle )
        return 1;
    else
        return compareDates(a,b);
}


function compareSources( a, b )
{
    var asrc = a.getAttribute("articlesortsource");
    var bsrc = b.getAttribute("articlesortsource");
    if( asrc < bsrc )
        return -1;
    else if( asrc > bsrc )
        return 1;
    else
        return compareDates(a,b);
}


function compareUnread( a, b )
{
    var aUnread = a.className.indexOf(sUnreadClass) >= 0;
    var bUnread = b.className.indexOf(sUnreadClass) >= 0;
    if( aUnread ) {
        if( ! bUnread )
            return -1;
    } else if( bUnread ) {
        if( ! aUnread )
            return 1;
    }
    return compareDates(a,b);
}

//// PAGINATION:
var sCurrentArticle = 0;
var sArticlesPerPage;
var sTotalPageCount;
var sIsPaginated = false;
var sResetPagination = false;
var previousarticles, previousarticle, currentarticles, nextarticles, nextarticle, pagination;
var sNextImageLocation, sNextDisabledImageLocation, sPreviousImageLocation, sPreviousDisabledImageLocation;

function setupPagination(articlesPerPage) {
    pagination = document.getElementById(sPaginationId);
    sArticlesPerPage = articlesPerPage;

    sIsPaginated = (sTotalArticleCount > sArticlesPerPage);
    // build image page names based off of one that's resolved (can't access rsrcpath template expansion)
    nextarticle = document.getElementById(sNextArticleId);
    sNextImageLocation = nextarticle.src;
    var imageLocation = sNextImageLocation.replace(/\/[^\/]*$/, "/");
    sNextDisabledImageLocation = imageLocation + 'NextPage_Disabled.tif';
    sPreviousImageLocation = imageLocation + 'PreviousPage.tif';
    sPreviousDisabledImageLocation = imageLocation + 'PreviousPage_Disabled.tif';
    
//console.log("setupPagination("+articlesPerPage+") total "+sTotalArticleCount+" paginated "+sIsPaginated);
    if (sIsPaginated) {
        resetPagination();
    } else {
        pagination.style.display = 'none';
    }
}

function resetPagination() {
    if( previousarticles == undefined ) {
        previousarticles = document.getElementById(sPreviousArticlesId);
        previousarticle = document.getElementById(sPreviousArticleId);
        currentarticles = document.getElementById(sCurrentArticlesId);
        nextarticles = document.getElementById(sNextArticlesId);
        nextarticle = document.getElementById(sNextArticleId);    
    }
    var countElem = document.getElementById(sTotalArticleCountId);
    if(countElem) {
        // Reload should pass new counts
        sTotalArticleCount = Number(countElem.getAttribute("total"));
	sUnreadCount = Number(countElem.getAttribute("unread"));
//console.log("resetPagination found total "+sTotalArticleCount+" unread "+sUnreadCount);
	redisplayCounts( )
    } else {
//console.log("resetPagination did not find counts, leaving "+sTotalArticleCount+" unread "+sUnreadCount); 
    }
    sTotalPageCount = Math.ceil(sTotalArticleCount / sArticlesPerPage);
    if (sTotalArticleCount <= sArticlesPerPage) {
        pagination.style.display = 'none';
    } else {
        sIsPaginated = true;
        previousarticles.style.display = 'none';
        var pages = currentarticles.childNodes;
        var amountToShow = Math.min(sTotalPageCount, 10);
        for (i = 0; i < amountToShow; i++) {
            pages[i].style.display = 'inline';
            pages[i].innerText = i + 1 + "";
            pages[i].className = null;
        }
        for (; i < pages.length; i++) {
            pages[i].style.display = 'none';
            pages[i].innerText = i + 1 + "";            
            pages[i].className = null;            
        }
        if (sTotalPageCount > pages.length) {
            nextarticles.style.display = 'inline';
        } else {
            nextarticles.style.display = 'none';
        }
        pages[0].className = sSelectedClass;
        previousarticle.src = sPreviousDisabledImageLocation;
        nextarticle.src = sNextImageLocation;
        pagination.style.display = 'inline';
    }
}

function goToPage(page) {
    var newCurrentArticle, currentPage;
    var previousPage = Math.ceil((sCurrentArticle+1) / sArticlesPerPage);
    var pages = currentarticles.childNodes;    
    switch(page) {
        case -4: // previous page
            if (sCurrentArticle != 0) {
                newCurrentArticle = sCurrentArticle - sArticlesPerPage;
                currentPage = previousPage - 1;
                // currentPage = 10, 20, 30...
                if( currentPage % 10 == 0 ) {
                    renumberPages(currentPage - 9, false);
                }
            }
            break;
        case -3: // last of previous 10 pages
            // 21 -> 20; 30 -> 20
            currentPage = Math.floor((previousPage - 11) / 10) * 10 + 10;
            newCurrentArticle = (currentPage - 1) * sArticlesPerPage;
            renumberPages(currentPage - 9, false);
            break;
        case -2: // first to next 10 pages
            // 11 -> 21; 20 -> 21
            currentPage = Math.floor((previousPage + 9) / 10) * 10 + 1;
            newCurrentArticle = (currentPage - 1) * sArticlesPerPage;
            renumberPages(currentPage, true);
            break;
        case -1: // next page
            if (sCurrentArticle + sArticlesPerPage < sTotalArticleCount) {
                newCurrentArticle = sCurrentArticle + sArticlesPerPage;
                currentPage = previousPage + 1;
                // currentPage = 1, 11, 21...
                if( currentPage % 10 == 1) {
                    renumberPages(currentPage, true);
                }                
            }
            break;
        default: // clicked on a particular number
            currentPage = Number(pages[page - 1].innerText);
            newCurrentArticle = (currentPage - 1) * sArticlesPerPage;
            break;
    }
    
    // Change the enabled/disabled state of the forward/back arrows
    switch (page) {
        // moving backwards
        case -4:
        case -3:
            // was on the last page, now we're not
            if (previousPage == sTotalPageCount) {
                nextarticle.src = sNextImageLocation;
            }
            if (currentPage == 1) {
                previousarticle.src = sPreviousDisabledImageLocation;
            }
            break;        
        // moving forwards
        case -2:
        case -1:
            // was on the first page, now we're not
            if (previousPage == 1) {
                previousarticle.src = sPreviousImageLocation;
            }
            if (currentPage == sTotalPageCount) {
                nextarticle.src = sNextDisabledImageLocation;
            }
            break;
        default:
            // could be going forwards or backwards
            if (currentPage == sTotalPageCount) {
                nextarticle.src = sNextDisabledImageLocation;
                previousarticle.src = sPreviousImageLocation;
            } else if (currentPage == 1) {
                nextarticle.src = sNextImageLocation;
                previousarticle.src = sPreviousDisabledImageLocation;            
            } else {
                nextarticle.src = sNextImageLocation;
                previousarticle.src = sPreviousImageLocation;            
            }        
            break;
    }
    if (newCurrentArticle != sCurrentArticle && newCurrentArticle >= 0) {
        pages[((previousPage - 1) % 10)].className = null;
        pages[((currentPage - 1) % 10)].className = sSelectedClass;
        sCurrentArticle = newCurrentArticle;    
        sendSyndicationCmd("setOffset",sCurrentArticle,true);		
    }
}

function renumberPages(startCount, countUp) {
    var pages = currentarticles.childNodes;
    for (i = 0; i < pages.length; i++) {
        pages[i].innerText = startCount + i + "";
    }
    // last page eg: 25 pages total, would show range 21 - 30, but need to clip it
    if (countUp && (startCount + 9) > sTotalPageCount) {
        for (i = (sTotalPageCount % 10); i < pages.length; i++) {
            pages[i].style.display = 'none';
        }
        // don't show "more"
        nextarticles.style.display = 'none';
    // next to last page eg: 25 pages total, need to show full range of 11-20; 11+19=30 > 25
    } else if (!countUp && (startCount + 19) > sTotalPageCount) {
        for (i = 0; i < pages.length; i++) {
            pages[i].style.display = 'inline';
        }    
        // show "more"
        nextarticles.style.display = 'inline';        
    }
    if (startCount == 1) {
        // first page; don't show "previous"
        previousarticles.style.display = 'none';
    } else {
        previousarticles.style.display = 'inline';    
    }
}

//// SLIDER:

var slider;
var scroller;

var pinnedElement;
var offsetFromTop;
var content;
var contentElements;
var scaling = false;
var pinnedSidebarTop;

function setupSlider() {
    if( slider === undefined ) {
        slider = document.getElementById(sSliderId);
        scroller = document.getElementById(sScrollerId);    
        // Initial value of appleLineClamp in the HTML doesn't take effect [3762017] so we have to change it:
        if( slider.value != 100 )
            document.getElementById(sContentId).style.appleLineClamp = slider.value + "%";
    }
}

function startScale()
{
    scaling = true;
    if( scroller == undefined ) scroller = document.getElementById(sScrollerId);
    var top = scroller.scrollTop;
    if( sidebar === undefined )
        sidebar = document.getElementById(sSidebarId);
    pinnedSidebarTop = top - sidebar.offsetTop;    
    if( contentElements == undefined ) {
        if ( content == undefined ) content = document.getElementById(sContentId);
        contentElements = new Array();
        var children = content.childNodes;
        var bottom = top + scroller.clientHeight;
        var found = 0;
        offsetFromTop = 0;
        var numItems = 0;
        var child;
        for (var i = 0; i < children.length; i++) {
            child = children[i];
            if (child.nodeType == 1) { // element
                contentElements.push(child);
                if (!found) {
                    var elementTop = child.offsetTop;
                    if (elementTop > top) {
                        // Item contents span entire window
                        if (elementTop > bottom && i > 0) {
                            pinnedElement = contentElements[numItems-1];
                        } else {
                            pinnedElement = child;
                        }
                        found = 1;
                    }
                }
                numItems++;
            }
        }
    } else if (contentElements.length > 0) {
        var bottom = top + scroller.clientHeight;
        var found = 0;
        offsetFromTop = 0;
        for (i = 0; !found && i < contentElements.length; i++) {
            var elementTop = contentElements[i].offsetTop;
            if (elementTop > top) {
                // Item contents span entire window
                if (elementTop > bottom && i > 0) {
                    pinnedElement = contentElements[i-1];
                } else {
                    pinnedElement = contentElements[i];
                }
                found = 1;
            }
        }
    }
    offsetFromTop = pinnedElement.offsetTop - top;
}

function endScale()
{
    scaling = false;
    slipDiffScroll( scroller );
    
    // Tell the back-end to update the prefs for this feed:
    sendSyndicationCmd("setSlider",""+slider.value);
}

function scaleArticles( value )
{
    if ( content == undefined ) content = document.getElementById(sContentId);

    if  ( value == 0 ) {
        content.className = "apple-rss-content apple-rss-single-line-mode";
        content.style.appleLineClamp = "";
    } else {
        content.className = "apple-rss-content apple-rss-multi-line-mode";
        content.style.appleLineClamp = value + "%";
    }

    if (pinnedElement != undefined) {
        scroller.scrollTop = pinnedElement.offsetTop - offsetFromTop;
    }
}

function scaleTo( value ) {
    if( value != slider.value ) {
        startScale();
        slider.value = value;
        scaleArticles( value ); // Need to call this because events aren't called when the value is programmatically called
        //console.log("slider="+slider+", slider.value="+slider.value+", should be "+value+" which is "+typeof(value));
        endScale();
    }
}

function scaleToMin() {
    scaleTo( slider.min );
}

function scaleToMax() {
    scaleTo( slider.max );    
}


//// SCROLLING:


function handleScrollKeys( event )
{
    if ( scroller == undefined ) scroller = document.getElementById(sScrollerId);
    if ( sFilterField == undefined ) sFilterField = document.getElementById(sSearchfieldId);
    var keyIdentifier = event.keyIdentifier;
    switch(keyIdentifier) {
        // A lot of key handling we had to do ourselves until 3/28/07 was removed,
        // because WebKit took over. Use source control history to see what we used
        // to do, if ever the need arises.
        case "Up":
            scroller.scrollByLines(-1);
            break;
        case "Down":
            scroller.scrollByLines(1);
            break;
        case "Home":
            scroller.scrollLeft = 0;
            scroller.scrollTop = 0;
            break;
        case "End":
            scroller.scrollLeft = 0;
            scroller.scrollTop = scroller.scrollHeight;
            break;
        case "U+000020":  // Space
        case "U+0020":
            if (sFilterField.value == "") {
                if (event.shiftKey) { // Page up if shift key is held down with space
                    scroller.scrollByPages(-1);
                } else {
                    scroller.scrollByPages(1);
                }
            } else {
                return;
            }
            break;
        default:
            return;
    }
    event.preventDefault();
}

var sidebar;

function slipDiffScroll(scroller)
{
    if( sidebar === undefined )
        sidebar = document.getElementById(sSidebarId);
    if (scaling) {
        sidebar.style.top = scroller.scrollTop - pinnedSidebarTop;
    } else {
        //console.log("scroller="+scroller+", height="+scroller.clientHeight+", scrollY="+scroller.scrollTop);
        var windowBottom = scroller.clientHeight + scroller.scrollTop;
        var viewportTop = scroller.scrollTop+8;
        
        var sidebarTop = windowBottom - 8 - sidebar.offsetHeight;
        //console.log("windowBottom="+windowBottom+", viewportTop="+viewportTop+", sidebarTop="+sidebarTop);
        if (sidebarTop < 8)
            sidebarTop = 8;                                         // Don't let top of sidebar fall off the top
        else if (sidebarTop > viewportTop)
            sidebarTop = viewportTop;                               // Don't let top of sidebar go below top of visible area
        sidebar.style.top = sidebarTop - 8;
        //console.log("sidebar.style.top = "+(sidebarTop-8));
    }
}

function keepArticleInView(articleToKeepInView)
{
    if ( scroller == undefined ) scroller = document.getElementById(sScrollerId);
    if ( articleToKeepInView == undefined ) {
        scroller.scrollTop = 0;
    } else {
        if( content == undefined ) content = document.getElementById(sContentId);
        var contentTop = content.offsetTop;
        var childBottom = contentTop + articleToKeepInView.offsetTop + articleToKeepInView.clientHeight + 3;
        var top = scroller.scrollTop;
        var bottom = top + scroller.clientHeight;
        // the last child's bottom and top is above the visible window
        if( contentTop < top && childBottom < bottom ) {
            scroller.scrollTop = childBottom - scroller.clientHeight;        
        }
    }
}

//// FOAF:


var FOAFRequest;

function loadFOAF( )
{
    var alternateURL = document.getElementById(sInfoId).getAttribute("alternateURL");
    FOAFRequest = requestForSyndicationCmd("getFOAF","", true);
    FOAFRequest.setRequestHeader("Alternate-Url", alternateURL);
    FOAFRequest.onload = function( ) {receivedFOAF(FOAFRequest.responseText);}
    FOAFRequest.send(null);
}


function replaceElementWithHTML( element, html )
{
    if( html ) {
        var node = document.createElement("DIV");
        node.innerHTML = html;
        // Find the actual HTML node, skipping any preceding whitespace:
        for( var i=0; i<node.childNodes.length; i++ ) {
            var child = node.childNodes[i];
            if( child.nodeType == Node.ELEMENT_NODE ) {
                element.parentNode.replaceChild(node,element);
                return;
            }
        }
    }
    element.parentNode.removeChild(element);
}


function receivedFOAF( html )
{    
    if ( html ) {
        var placeholder = document.getElementById(sFOAFPlaceholderId);    
        replaceElementWithHTML(placeholder,html);
    }
}


function swapOut( outID, inID )
{
    document.getElementById(outID).style.display = "none";
    document.getElementById(inID) .style.display = "block";
}


//// TOOLS:

function bookmarkFeed()
{
    var bookmarker = null;
    var urlToBookmark = document.location.href;
    try {
        bookmarker = new PubSubBookmarker();
        if (bookmarker)
            bookmarker.addBookmark(urlToBookmark);
    } catch (e) {
        // If this has failed, use the other means of bookmarking available to us.
    }
    if ( !bookmarker && window.pubsub)
        window.pubsub.addBookmark(urlToBookmark);
}

function subscribeInMail()
{
    sendSyndicationCmd( "subscribeInMail","");
}


//// SETUP:

function updateIconHref( alternateURL )
{ 
    // The template code might know the alternateURL already. If it does, use it. If not,
    // pass in the feed url.
    var referenceURL = (alternateURL && alternateURL != "") ? alternateURL : document.location.href;  
    var faviconURL = null;   
    var favicon = null;
    
    try {
        favicon = new PubSubFavicon();
        if (favicon)
            faviconURL = favicon.getURL(referenceURL);
    } catch (e) {
        // If this has failed, use the other means of getting the favicon available to us.
    }
    
    if( !favicon && window.pubsub )
        faviconURL = window.pubsub.faviconURL(referenceURL);
        
    // This updates the hrefs in the live DOM, but don't be surprised that it doesn't
    // affect the generated HTML. Still works just fine!
    if ( faviconURL )
        document.getElementById(sIconLinkId).setAttribute("href", faviconURL);
}

function updateSettingsIfAfter( timeCreated )
{
    // If the page is being loaded more than 5 seconds after it was created, fetch the current
    // sidebar settings and update if they've changed:
    if( (new Date().getTime())-timeCreated > 5000 ) {
        var post = requestForSyndicationCmd("getSettings","");
        post.onload = function() {receivedSettings(post.responseText);};
        post.send(null);
    }
}

function receivedSettings( text ) 
{
    var settings = text.split("\n");
//console.log("receivedSetting "+text);
    sSendCommands = false;      // Don't tell the back-end about "changes" to settings
    
    var sort = parseInt(settings[0]);
    if( sort != currentSort() )
        sortArticlesBy(sort);

    var timespan = parseInt(settings[1]);
    if( timespan != currentTimespan() )
        setDateFilter(timespan);
     
    setupSlider();
    var newSlider = parseInt(settings[2]);
    scaleTo(newSlider);
    
    var source = settings[3];
    if( source != currentSourceFilter() )
        setSourceFilter(source);
    
    sSendCommands = true;
}


function setupSourceNames( /*varargs*/ )
{
    var sourceLinks = document.getElementById(sSourcelistId).getElementsByTagName("a");
    for( var i=0; arguments[i]; i++ )
        sourceLinks[i].innerText = arguments[i];
}


function setupTitle( title )
{
    document.title = title;
    document.getElementById(sTitleTextId).innerText = title;
    document.getElementById(sSourceNameTextId).innerText = title;
}


function setupAlternateURL()
{
    // alternateURL is set up by the Feed.html template, and fed into our native
    // Javascript object here, for use by our native code that communicates with the
    // Safari application directly.
    var bookmarker = null;
    var alternateURL = document.getElementById(sInfoId).getAttribute("alternateURL");
    try {
        bookmarker = new PubSubBookmarker();
        if (bookmarker)
            bookmarker.setAlternateURL(alternateURL);
    } catch (e) {
        // If this has failed, use the other means of setting alternateURL available to us.
    }
    if ( !bookmarker && window.pubsub )
        window.pubsub.setAlternateURL(alternateURL);
}


/* This is called via an onLoad handler when the page finishes loading. */
function setup( )
{
    setupFilter();
    setupSlider();
    setURLToBookmark();
    setupAlternateURL();
}

