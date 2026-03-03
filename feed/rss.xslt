<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="rss/channel/title"/></title>
        <link rel="stylesheet" type="text/css" href="/global/feed/styles.css"/>
        <script type="text/javascript">
            function stripHTML(txt) {
                const tmp = document.createElement("div");
                tmp.innerHTML = txt;
                return tmp.textContent || tmp.innerText || "";
            }

            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.cleanHTML').forEach(desc => {desc.textContent = stripHTML(desc.innerHTML);});
            });
        </script>
      </head>
      <body>
        
        <div class="container">
          <a href="https://acast.com" title="Podcasting For Creators and Advertisers | Acast Podcasts"><div class="header"></div></a>
          <div class="podcast-header">

          <img class="cover-image">
              <xsl:attribute name="src">
                  <xsl:value-of select="/rss/channel/image/url"/>
              </xsl:attribute>
              <xsl:attribute name="alt">
                  <xsl:value-of select="/rss/channel/title"/>
              </xsl:attribute>
          </img>
          <div class="podcast-info">
              <h1 class="podcast-title"><xsl:value-of select="/rss/channel/title"/></h1>
              <div class="podcast-description cleanHTML"><xsl:value-of select="/rss/channel/description" disable-output-escaping="yes"/></div>
          </div>
        </div>
          <h2>All Episodes</h2>
          <div class="episodes">
            <xsl:apply-templates select="rss/channel/item"/>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="item">
    <div class="episode">
      <img class="episode-cover">
        <xsl:attribute name="src"><xsl:value-of select="itunes:image/@href"/></xsl:attribute>
      </img>
    <div class="episode-info">
        <h2 class="episode-title"><xsl:value-of select="title"/></h2>
        <p class="episode-date">
          <xsl:value-of select="substring(pubDate, 8, 4)"/> <xsl:value-of select="substring(pubDate, 5, 3)"/>, <xsl:value-of select="substring(pubDate, 12, 5)"/>
        </p>

        <div class="media-player">
            <xsl:if test="count(child::enclosure)&gt;0">
                <xsl:if test="contains(enclosure/@type, 'video')">
                    <video controls="controls" preload="none">
                        <xsl:element name="source">
                            <xsl:attribute name="src">
                                <xsl:value-of select="enclosure/@url"/>
                            </xsl:attribute>
                            <xsl:attribute name="type">
                                <xsl:value-of select="enclosure/@type"/>
                            </xsl:attribute>
                        </xsl:element>
                    </video>
                </xsl:if>
                <xsl:if test="contains(enclosure/@type, 'audio')">
                    <audio class="audio-player" controls="controls" preload="none">
                        <xsl:attribute name="src"><xsl:value-of select="enclosure/@url"/></xsl:attribute>
                    </audio>
                </xsl:if>
            </xsl:if>
        </div>
    </div>
    <div class="episode-description cleanHTML">
        <xsl:value-of select="description" disable-output-escaping="yes"/>
    </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
