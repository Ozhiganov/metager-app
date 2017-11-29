var TRIES = 3;
var TRYDELAYINCRMS = 1000;

function loadXMLDoc(filename)
{
var xhttp = new XMLHttpRequest();
xhttp.open("GET", filename, false);
xhttp.send("");
return xhttp.responseXML;
}

function render(err, content)
{
	if (err) {
		alert("Fehler bei der Suche! Bitte prüfen Sie Ihr Netzwerk.("+err+")");
		location.href="index.xhtml";
	} else {
	  style = loadXMLDoc("style/material.xsl");
	  if (document.implementation && document.implementation.createDocument)
	    {
	    xsltProcessor = new XSLTProcessor();
	    xsltProcessor.importStylesheet(style);
	    resultDocument = xsltProcessor.transformToFragment(content, document);
	    document.body.replaceChild(resultDocument, document.getElementById("temp"));
	    }
	}
}

/**
 * Delivers OpenSearch responseXML to callback for the given query.
 */
function search(query,focus,callback, trycount) {
  query = query || "eingabe=";
  focus = focus || "focus=web";
	var doc;
	trycount = trycount || 0;
	try {
		doc = loadXMLDoc("https://metager3.de/meta/meta.ger3?"+focus+"&"+query+"&encoding=utf8&out=atom10&appversion=3.0.1");
		callback(null, doc);
	} catch (e) {
		if(++trycount < TRIES) {
			console.log("search error, tries left: "+ (TRIES - trycount) );
			setTimeout(search, trycount * TRYDELAYINCRMS, query, focus, callback, trycount);
		} else {
			console.log("search failed");
			callback(e);
		}
	};
}

function boot()
{
  search(getParameter('eingabe'),getParameter('focus'),render);
}

function filterFunc(p,i,a)
{
	return p.startsWith(parameterName + "=");
}

function getParameter(parameterName) {
	var parameterStrings = location.search.substr(1).split("&");
	var results = parameterStrings.filter(function(p,i,a) {
  return p.lastIndexOf(parameterName + "=", 0) === 0;
});
	return results.join("&");
}

function openResult(url)
{
  cordova.InAppBrowser.open(url,'_system');
}
