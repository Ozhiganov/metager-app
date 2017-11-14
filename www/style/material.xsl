<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/"
	xmlns:ad="http://a9.com/-/opensearch/extensions/advertisement/1.0/"
	xmlns="http://www.w3.org/1999/xhtml">

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="atom:feed">
		<body>
			<header class="persistent-search">
    			<form class="search-card card elevation-2" id="searchform">
    				<a href="https://metager.de" class="back">
    					<img src="img/Logo-square-inverted.svg" alt="MetaGer" title="MetaGer, die sichere Suchmaschine"/>
    				</a>
    				<input type="text" name="eingabe" placeholder="MetaGer-Suche" value="{opensearch:Query[@role='request']/@searchTerms}" class="query-input"/>
    				<button type="submit" class="search-button fa"></button>
    			</form>
				</header>
    		<main class="results-container">
          <xsl:apply-templates select="atom:entry|ad:advertisement"/>
    		</main>
    		<footer class="footer-text">
    		MetaGer wird entwickelt und betrieben vom SUMA-EV - Verein für freien Wissenszugang.
    		</footer>
			</body>
  </xsl:template>

	  <xsl:template match="atom:entry">
	    <article class="search-result card elevation-1">
	      <div class="result-content" onclick="openResult('{atom:link/@href}')">
	                  <h1 class="result-title"><xsl:apply-templates select="atom:title"/></h1>
	                  <h2 class="result-display-link"><xsl:apply-templates select="atom:link"/></h2>
	                  <p class="result-description">
	                    <xsl:apply-templates select="atom:content"/>
	                  </p>
	      </div>
	      <div class="result-action-area">
	                  <a class="result-action primary" href="{atom:link/@href}">Öffnen</a>
	                  <a class="result-action primary" onclick="cordova.InAppBrowser.open('{atom:link/@href}', '_blank', 'location=yes,clearcache=yes,clearsessioncache=yes')" href="#">In-App</a>
	      </div>
	    </article>
	  </xsl:template>

    <xsl:template match="ad:advertisement">
      <article class="search-result card elevation-1 ad-advertisement">
        <div class="result-content" onclick="openResult('{atom:link/@href}')">
					<small class="ad-callout"><xsl:apply-templates select="ad:callOut"/></small>
          <h1 class="result-title"><xsl:apply-templates select="ad:title"/></h1>
          <h2 class="result-display-link"><xsl:apply-templates select="ad:displayUrl"/></h2>
          <p class="result-description">
							<xsl:apply-templates select="ad:subTitle"/>
          </p>
        </div>
      </article>
    </xsl:template>
      <xsl:template match="atom:link">
        <xsl:value-of select="@href"/>
    </xsl:template>
</xsl:stylesheet>
