function loadXMLDoc(filename)
{
var xhttp = new XMLHttpRequest();
xhttp.open("GET", filename, false);
xhttp.send("");
return xhttp.responseXML;
}

function render(content)
{
  style = loadXMLDoc("style/material.xsl");
  if (document.implementation && document.implementation.createDocument)
    {
    xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(style);
    resultDocument = xsltProcessor.transformToFragment(content, document);
    document.body.replaceWith(resultDocument);
    }
}

/**
 * Returns OpenSearch responseXML for the given query.
 */
function search(query,focus) {
  query = query || "eingabe=";
  focus = focus || "focus=web";
  return loadXMLDoc("https://metager3.de/meta/meta.ger3?"+focus+"&"+query+"&encoding=utf8&out=atom10&appversion=0.1.0");
}

function boot()
{
  render(search(getParameter('eingabe'),getParameter('focus')));
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
