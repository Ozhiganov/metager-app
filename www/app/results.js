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

	} else {
	  style = loadXMLDoc("style/material.xsl");
	  if (document.implementation && document.implementation.createDocument)
	    {
	    xsltProcessor = new XSLTProcessor();
	    xsltProcessor.importStylesheet(style);
	    resultDocument = xsltProcessor.transformToFragment(content, document);
	    document.body.replaceWith(resultDocument);
	    }
	}
}

/**
 * Delivers OpenSearch responseXML to callback for the given query.
 */
function search(query,focus,callback, tries) {
  query = query || "eingabe=";
  focus = focus || "focus=web";
	let doc;
	tries = tries || 3;
	try {
		doc = loadXMLDoc("https://metager3.de/meta/meta.ger3?"+focus+"&"+query+"&encoding=utf8&out=atom10&appversion=3.0.0");
		callback(null, doc);
	} catch (e) {
		if(--tries) {
			console.log("search error, tries left: "+tries);
			search(query, focus, callback, tries);
		} else {
			callback(e);
		}
	};
}

function boot()
{
  search(getParameter('eingabe'),getParameter('focus'),render);
}

function getParameter(parameterName) {
	const parameterStrings = location.search.substr(1).split("&");
	const results = parameterStrings.filter((p, i, a) => p.startsWith(parameterName + "="));
	return results.join("&");
}

function openResult(url)
{
  cordova.InAppBrowser.open(url,'_system');
}
